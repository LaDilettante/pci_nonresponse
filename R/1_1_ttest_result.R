rm(list=ls())
packs <- c("stringr", "plyr", "ggplot2")
new.packs <- packs[!(packs %in% installed.packages()[ , "Package"])]
if(length(new.packs)) install.packages(new.packs, repos='http://cran.us.r-project.org')
lapply(packs, library, character.only=TRUE)
rm(packs)

# Load functions
source("./functions.R")
# Load data
load("../data/PCI2012_DDI.RData")

# Grep all the questions in section D
questions <- names(d_ddi)[str_detect(names(d_ddi), "^d[0-9]")]

# Run the ttest on multiple variables
# f_ttest from functions.R
tmp <- ldply(questions, function(x) f_ttest(df=d_ddi, varname=x))
tmp <- tmp[complete.cases(tmp), ]
tmp2 <- tmp[tmp[, "p.value"] < 0.05 , ]

# Plotting result
ggplot(data=tmp, aes(x=varname)) +
  geom_errorbar(aes(ymin=conf.int.low95, ymax=conf.int.hi95)) +
  geom_hline(aes(yintercept=0, col="red")) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(title="Nonresponse Rate Before ACB - Nonreponse Rate After ACB",
       x="Variable",
       y="95% confidence interval")
ggsave(filename="../fig/ttest_result.pdf", height=7, width=7)
