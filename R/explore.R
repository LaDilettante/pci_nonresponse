rm(list=ls())

load("./data/PCI2012_DDI.RData")

names(d_ddi)

d_ddi_dict[d_ddi_dict$var.name=="h4" ,]
