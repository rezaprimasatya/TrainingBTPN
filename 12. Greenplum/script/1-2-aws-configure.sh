#!/bin/bash

if [ -d $HOME/.aws ]; then rm -rf $HOME/.aws; fi

mkdir $HOME/.aws

echo "[default]
aws_access_key_id="$1"
aws_secret_access_key="$2"" > $HOME/.aws/credentials

echo "[default]
region=eu-west-2
output=json" > $HOME/.aws/config

#test aws config
if [ "$(/usr/local/bin/aws s3 ls s3://amazon-reviews-pds/tsv/ | awk '{print $4}' | awk 'END {print NR}')" -eq "0" ]; 
  then echo "Error on AWS S3 Configuration setup"; 
  else echo "AWS S3 Configuration setup correctly"; 
fi
