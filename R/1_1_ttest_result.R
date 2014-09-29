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

# Function to run t test
f_ttest <- function(df, varname) {
  var <- df[ , varname]
  res <- with(df, t.test(is.na(var) ~ whether_after_ACB))
  return(data.frame(
    varname=varname,
    varlabel=ddi_labels[[varname]],
    beforeACB=unname(res$estimate[1]),
    afterACB=unname(res$estimate[2]),
    conf.int.low95=unname(res$conf.int[1]),
    conf.int.hi95=unname(res$conf.int[2]),
    p.value=res$p.value,
    sig=ifelse(res$p.value <= 0.01, "***", 
               ifelse(res$p.value <= 0.05, "**",
                      ifelse(res$p.value <= 0.1, "*", "")))))
}

# Run the ttest on multiple variables
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
