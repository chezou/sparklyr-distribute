# distributing R code with sparklyr's spark_apply()

This is a test repo for spark_apply function of sparklyr, whch enables you to distribute R code like SparkR.

There is two options:

1. Install R on worker nodes with R parcel: https://github.com/chezou/cloudera-parcel
   Example code: dist_sparklyr.r

2. Use conda env
   Set up script: prepare_conda_env.sh
   Example code: dist_sparklyr_conda.r


## Requirements

Before running both example codes, you should install folowing packages.

```
devtools::install_github("rstudio/sparklyr")
install.packages('broom')
```

## FAQ

1. distributing packages dependent with libicu does not work properly. See also [this issue](https://github.com/chezou/cloudera-parcel/issues/2)
