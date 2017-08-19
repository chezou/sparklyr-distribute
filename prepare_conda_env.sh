#!/bin/bash

conda create -p ~/r_env --copy -y -q r-essentials -c r
sed -i "s,/home/<USERNAME>,./r_env.zip,g" r_env/bin/R 
zip -r r_env.zip r_env
