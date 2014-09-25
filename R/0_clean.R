rm(list=ls())
packs <- c("foreign")
lapply(packs, library, character.only=TRUE)

d_ddi <- read.dta("./data/PCI2012_DDI_cleanH_final.dta")

ddi_labels <- new.env()
for (i in seq_along(names(d_ddi))) {
  ddi_labels[[names(d_ddi)[i]]] <- attr(d_ddi, "var.labels")[i]  
}

save(d_ddi, d_ddi_dict, file="./data/PCI2012_DDI.RData")
