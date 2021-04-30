#!/bin/bash

export S3_DATA_DIR=/var/tmp_s3_data

if [ -d $S3_DATA_DIR ]; then rm -rf $S3_DATA_DIR; fi

mkdir $S3_DATA_DIR
sudo chown gpadmin $S3_DATA_DIR
cd $S3_DATA_DIR

ls -laF $S3_DATA_DIR

/usr/local/bin/aws s3 cp s3://uber-movement-ldn/PCD_OA_LSOA_MSOA_LAD_AUG19_UK_LU.csv PCD_OA_LSOA_MSOA_LAD_AUG19_UK_LU.csv
/usr/local/bin/aws s3 cp s3://uber-movement-ldn/uber-movement-ldn.tar.gz uber-movement-ldn.tar.gz
/usr/local/bin/aws s3 cp s3://uber-movement-ldn/ukpostcodes.csv ukpostcodes.csv
/usr/local/bin/aws s3 cp s3://uber-movement-ldn/2018-MRDB-minimal.shp 2018-MRDB-minimal.shp
/usr/local/bin/aws s3 cp s3://uber-movement-ldn/2018-MRDB-minimal.shx 2018-MRDB-minimal.shx
/usr/local/bin/aws s3 cp s3://uber-movement-ldn/2018-MRDB-minimal.dbf 2018-MRDB-minimal.dbf
/usr/local/bin/aws s3 cp s3://uber-movement-ldn/dft_traffic_counts_raw_counts.tar.gz dft_traffic_counts_raw_counts.tar.gz
