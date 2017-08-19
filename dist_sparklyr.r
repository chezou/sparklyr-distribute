# Before running this code, you should install following packages:
#devtools::install_github("rstudio/sparklyr")
#install.packages('broom')

library(sparklyr)

config <- spark_config()
config[["spark.r.command"]] <- "/opt/cloudera/parcels/CONDAR/lib/conda-R/bin/Rscript"
config$sparklyr.apply.env.R_HOME <- "/opt/cloudera/parcels/CONDAR/lib/conda-R/lib/R"
config$sparklyr.apply.env.RHOME <- "/opt/cloudera/parcels/CONDAR/lib/conda-R"
config$sparklyr.apply.env.R_SHARE_DIR <- "/opt/cloudera/parcels/CONDAR/lib/conda-R/lib/R/share"
config$sparklyr.apply.env.R_INCLUDE_DIR <- "/opt/cloudera/parcels/CONDAR/lib/conda-R/lib/R/include"


sc <- spark_connect(master = "yarn-client", config = config)

sdf_len(sc, 5, repartition = 1) %>%
  spark_apply(function(e) I(e))
    
iris_tbl <- sdf_copy_to(sc, iris)

spark_apply(
  iris_tbl,
  function(e) broom::tidy(lm(Petal_Length ~ Petal_Width, e)),
  names = c("term", "estimate", "std.error", "statistic", "p.value"),
  group_by = "Species",
  packages = FALSE)
