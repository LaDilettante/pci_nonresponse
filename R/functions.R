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