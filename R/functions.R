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

f_proptest <- function(df, varname, groupvar) {
  group <- df[ , groupvar]
  var0 <- df[group==0 , varname]
  var1 <- df[group==1 , varname]
  res0 <- prop.test(x=sum(is.na(var0)), n=length(var0))
  res1 <- prop.test(x=sum(is.na(var1)), n=length(var1))
  return(data.frame(
    varname = rep(varname, 2),
    varlabel = rep(ddi_labels[[varname]], 2),
    whether_after_ACB = c(0, 1),
    mean = c(res0$estimate, res1$estimate),
    mean.low95 = c(res0$conf.int[1], res1$conf.int[1]),
    mean.hi95 = c(res0$conf.int[2], res1$conf.int[2])
  ))
}

