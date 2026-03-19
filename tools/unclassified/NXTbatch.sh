#!/bin/bash
#SBATCH --job-name=NXT_batch
#SBATCH --out="NXT_batch.out"
#SBATCH --nodes=1 --ntasks=1 --cpus-per-task=8
#SBATCH --mem-per-cpu=8G
#SBATCH --mail-type=ALL


###################### prepare working directory ####################

read -e -p "Enter your working directory (default: current): " -i $PWD wd

cd $wd

! [[ -d ./Samples_categorized/ ]] && mkdir ./Samples_categorized/
! [[ -d ./Samples_undetermined/ ]] && mkdir ./Samples_undetermined/
[[ -f ./Fastq/Undetermined* ]] && mv ./Fastq/Undetermined* ./Samples_undetermined/

declare -A sample_list=()
cd ./Fastq/
for sample in *.fastq.gz; do sample_list[$(echo $sample | cut -d '-' -f1)]=0; done
cd ../

for gene in ${!sample_list[@]}
do
  mkdir ./Samples_categorized/$gene/
  cp ./Fastq/$gene* ./Samples_categorized/$gene/
done

echo -e "\nFastq files categorized successfully! \n"


################## run cutadapt (for clean up) and CRISPResso2 (for analysis) ###################

# make sure you have bowtie2+CRISPResso2 in current active conda environment

module purge
module load cutadapt

cd $wd
cd ./Samples_categorized/

echo -e "\nAnalysis launched. \n"

for gene in ${!sample_list[@]} #multiple assays
do
  cd ./$gene/
  declare -A assays=()
  for one_sample in *; do assays[$(echo $one_sample | cut -d '_' -f1)]=0; done
  touch IgnoreMe_$gene.log

  for assay in ${!assays[@]} #loop in each group
  do
    ###### 1st step: run cutadapt to clean up transposon contamination #####
    num=$(($(zcat $assay*.gz | wc -l)/8)) #number of reads for each sample
    if [[ $num -gt 100000 ]]
    then
      echo -e "Satisfied! Proceed. Sample $assay has: $num reads. \n" >> IgnoreMe_$gene.log
      #use cutadapt to remove Nextera transposase contamination 
      read1=$assay*R1*.gz
      read2=$assay*R2*.gz
      out1=$(echo $read1 | cut -d '.' -f 1)"_trimmed"".fastq"
      out2=$(echo $read2 | cut -d '.' -f 1)"_trimmed"".fastq"
      #run cutadapt! 
      cutadapt -a CTGTCTCTTATACACATCT -A AGATGTGTATAAGAGACAG -o $out1 -p $out2 $read1 $read2 2>> IgnoreMe_$gene.log
    else
      echo -e "Unsatisfied. Skip. Sample $assay has: $num reads. \n" >> IgnoreMe_$gene.log
    fi

    ###### 2nd step: run CRISPresso2 to quantify editing at target site #####
    num_trimmed=$(($(cat $assay*trimmed.fastq | wc -l)/8)); #number of reads for each reads-trimmed sample
    if [[ $num_trimmed -gt 100000 ]]
    then
        echo -e "Satisfied! Proceed. File $assay _trimmed has: $num_trimmed reads. \n" >> IgnoreMe_$gene.log
        #Parse the name of fastq files for each sample
        trimmed_read1=$assay*R1*_trimmed.fastq
        trimmed_read2=$assay*R2*_trimmed.fastq
        #for each gene-guide, retrieve amplicon and guide sequence 
        guide_seq=$(echo -e $(awk 'BEGIN{ORS=""}{ if($1 == "'$gene'") print $2;}' ../../reference.txt) | tr -d '\r')
        amplicon_seq=$(echo -e $(awk 'BEGIN{ORS=""}{ if($1 == "'$gene'") print $3;}' ../../reference.txt) | tr -d '\r')
        echo -e "\nThe amplicon sequence of $assay is: $amplicon_seq"
        echo -e "The guide sequence of $assay is: $guide_seq\n"
        #run CRISPresso2 using the information retrieved 
        echo -e "\n###### RUN CRISPRESSO2 FOR SAMPLE: $assay  ######\n"
        CRISPResso -r1 $trimmed_read1 -r2 $trimmed_read2 --max_paired_end_reads_overlap 135 -a $amplicon_seq -g $guide_seq -gn $assay -n $assay"_esso" -w 5 -wc -2 --exclude_bp_from_left 30 --exclude_bp_from_right 30 --annotate_wildtype_allele WT --plot_window_size 12 --debug
    else
        echo -e "Unsatisfied. Skip. File "$assay"_trimmed has: $num_trimmed reads. \n" >> IgnoreMe_$gene.log
    fi

    (eval printf %.1s '-{1..'"${COLUMNS:-$(tput cols)}"\}; echo) >> IgnoreMe_$gene.log
  done
  unset assays
  cd ../
  echo -e "\nTarget $gene done. \n"
done

echo -e "\nAll analysis complete. Have a nice day :)\n"
