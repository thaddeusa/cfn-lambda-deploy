# cfn-lambda-deploy
Bash scripts that help streamline deployment of lambda function(s) and their new version(s) via CloudFormation

__This is an older, outdated method. There are currently better ways to accomplish CI/CD with Lambda deployemnts, but this is a good starter method for local testing.__

## Bash scripts

1. upload-zip-s3.sh
2. cfn-lambda.sh

- They must be run in order, but could be combined into one script, if desired
- Variables must be set in each script for your chosen script names, file names, S3 bucket, stack name, etc
- Assumes the CloudFormation template (yaml file) is in the current directory
- Only tested on macOS