rm(list=ls())
pack <- c("stringr")
lapply(pack, library, character.only=TRUE)

load("./data/PCI2012_DDI.RData")

ddi_labels[["d10"]]
ddi_labels[["d11"]]

questions <- names(d_ddi)[str_detect(names(d_ddi), "^d[0-9]")]
questions_names <- ddi_labels[[questions]]

sapply(questions, function(i) ddi_labels[[i]])

names(d_ddi)

d_ddi$answerdate
