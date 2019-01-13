#!/bin/bash

# Assumes the specified bucket exists and has S3 versioning turned on.
# Zips up specified script file, and uploads the zip to S3 for use in CloudFormation deployment.
# Retrieves the S3 object version of the uploaded file and stores it locally in a text file.
# The subsequent bash script (cfn-lambda.sh) uses the stored version.

bucket=lambda-functions-example-bucket
script_file=lambda_function.py
zip_file=lambda_function.zip

zip -r $zip_file $script_file

aws s3 cp ${zip_file}.zip s3://${bucket}/

s3_zip_version=`aws s3api list-object-versions --bucket ${bucket} --prefix ${zip_file} | jq -r '.Versions[0].VersionId'`

echo $s3_zip_version > s3_zip_version.txt
