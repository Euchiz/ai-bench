# Example commands

## Convert RNA to DNA

```bash
python nuc_helper.py "AUG CUG UAA" --to dna
```

Expected final output block:

```text
ATGCTGTAA
```

## Convert DNA to RNA and reverse complement

```bash
python nuc_helper.py "ATGCATGC" --to rna --revcomp
```

Expected final output block:

```text
GCAUGCAU
```

## Invalid mixed sequence

```bash
python nuc_helper.py "AUTG" --to dna
```

This should fail validation because both `T` and `U` are present.
