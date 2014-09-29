rm(list=ls())

# Set up package dependencies
packs <- c("foreign", "lubridate", "dplyr")
new.packs <- packs[!(packs %in% installed.packages()[,"Package"])]
if(length(new.packs)) install.packages(new.packs, repos='http://cran.us.r-project.org')
lapply(packs, library, character.only=TRUE)
rm(packs)

# Load data
d_ddi <- read.dta("../data/PCI2012_DDI_cleanH_final.dta")

# Create an environment that contains STATA var label
ddi_labels <- new.env()
for (i in seq_along(names(d_ddi))) {
  ddi_labels[[names(d_ddi)[i]]] <- attr(d_ddi, "var.labels")[i]  
}

# Clean data
names(d_ddi)

cDAY_OF_ACB <- ymd("2012-08-21")
d_ddi <- d_ddi %>%
  mutate(answerdate = mdy(answerdate)) %>%
  mutate(days_after_ACB = as.numeric(answerdate - cDAY_OF_ACB) / 3600 / 24) %>%
  mutate(whether_after_ACB = days_after_ACB >= 0)

save(d_ddi, ddi_labels, file="../data/PCI2012_DDI.RData")
