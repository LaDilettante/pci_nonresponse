R_OPTS=--no-save --no-restore --no-init-file --no-site-file

data/PCI2012_DDI.RData: data/PCI2012_DDI_clean.dta R/0_clean.R
	cd R;R CMD BATCH $(R_OPTS) 0_clean.R