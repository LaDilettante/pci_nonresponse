rm(list=ls())
# Load package
packs <- c("stringr", "plyr", "ggplot2")
new.packs <- packs[!(packs %in% installed.packages()[ , "Package"])]
if(length(new.packs)) install.packages(new.packs, repos='http://cran.us.r-project.org')
lapply(packs, library, character.only=TRUE)
rm(packs)
# Load functions
source("./functions.R")
# Load data
load("./data/PCI2012_DDI.RData")

labs <- do.call(rbind, lapply(names(d_ddi), function(x) c(x, ddi_labels[[x]])))
head(d_ddi$form)
names(d_ddi)
# For DDI
# d14_2010 is experimental. Form A no corruption option

# For FDI
# j7 - num of activities to cultivate good relation
# j5 - impact of tax vs corruption
# c6 - number of activities during registration
# e5, non experimental - Do officials use regulation to extract fees
# b3, non experimental