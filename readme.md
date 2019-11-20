# Overview
Assuming you have an instance (whether in EC2, ECS, or Kubernetes) which performing console log to cloudwatch, then this repo is to pipeline the cloudwatch log to loggly

# Execution
1. Follow instruction step #1, #2, #7 in here https://www.loggly.com/docs/cloudwatch-logs/ to setup the KMS key with alias 'logglyKmsKey', Lambda role with name 'Cloudwatch-Full-Access-Loggly-Role', and assign the lambda role to KMS key admin/and user.
2. Download the Lambda function from the blueprint as outline in the above 'docs/cloudwatch-logs/', save it with name 'CloudwactchToLoggly.js' and zip it. Upload the zip file to your own S3 bucket
3. Change arguments in setupLog.sh accordingly and Execute setupLog.sh