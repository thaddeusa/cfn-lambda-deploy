#!/bin/bash -e

# This bash script runs the specified CloudFormation command (create, update, delete, describe, list)
# Designed to simplify the process of deploying new versions of a Lambda function via CloudFormation

# Uses Parameter Keys that must exist in the CloudFormation template being deployed
# Currently uses 'S3BUCKET' and 'S3ZIPVERSION'

stack=$1
task=$2
file=template-file.yaml
bucket=lambda-functions-example-bucket
s3_zip_version=`cat s3_zip_version.txt`

usage() {
  echo "
  ./cf-lambda.sh [stack-name] [task]

  Example:
    ./cf-lambda.sh my-lambda-cfn create

  Supported Commands:
    create
    update
    delete
    describe
    list
  "
}

create_stack() {
  aws cloudformation create-stack \
  --stack-name $stack \
  --capabilities CAPABILITY_NAMED_IAM \
  --template-body file://$file \
  --parameters \
  ParameterKey=S3BUCKET,ParameterValue=$bucket \
  ParameterKey=S3ZIPVERSION,ParameterValue=$s3_zip_version
}

update_stack() {
  aws cloudformation update-stack \
  --stack-name $stack \
  --capabilities CAPABILITY_NAMED_IAM \
  --template-body file://$file \
  --parameters \
  ParameterKey=S3BUCKET,ParameterValue=$bucket \
  ParameterKey=S3ZIPVERSION,ParameterValue=$s3_zip_version
}

delete_stack() {
  aws cloudformation delete-stack \
  --stack-name $stack
}

describe_stack() {
  aws cloudformation describe-stacks \
  --stack-name $stack | jq -r '.Stacks[] | .StackName,.StackStatus'
}

list_stacks() {
  aws cloudformation describe-stacks | jq -r .Stacks[].StackName
}

case $task in
  create)
    create_stack
    ;;
  update)
    update_stack
    ;;
  delete)
    delete_stack
    ;;
  describe)
    describe_stack
    ;;
  list)
    list_stacks
    ;;
  -h|--help|help|*)
    usage
    ;;
esac
