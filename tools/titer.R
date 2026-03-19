library(tidyverse)
library(readxl)

wd <- "E:/zaczou/Research/Chen Lab/projects/CAR-NK (reviewing)/data/12-09titer/"
rawfile <- "2022-12-09_AAV.xls"
stdfile <- "stdcurve.csv"

#-----------------------------------------------------#

setwd(wd)
data <- read_excel(rawfile, sheet = "Results", skip = 42) %>%
  dplyr::select(c(Sample = `Sample Name`, meanCT = `Ct Mean`))
std.dict <- readr::read_csv(stdfile)

stdcurve <- dplyr::left_join(std.dict, data, by = "Sample") %>%
  unique() %>%
  dplyr::mutate(logConc = log10(StdConc))
coefs <- coef(lm(logConc~meanCT, stdcurve))
result <- data[!data$Sample %in% std.dict$Sample, ] %>%
  unique() %>%
  dplyr::mutate(Conc = 10^(meanCT*coefs[2] + coefs[1])) %>%
  dplyr::mutate(OriginalConc_10x = 10*Conc) %>%
  dplyr::mutate(Titer = formatC(OriginalConc_10x*6.0221*10^23/(5745*660*10^9), format = "e", digits = 3))
show(result)
write_excel_csv(result, "titer.csv")
