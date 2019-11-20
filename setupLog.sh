# parameter arguments
logglyToken="[derive the customer token from loggly admin page and put it here]"
serviceName="CatalogService"
stackEnv="QA"
stackName="loggly-$serviceName"

# delete stack
# aws cloudformation delete-stack --stack-name "$stackName"

keyMetadata=$(aws kms describe-key --key-id alias/logglyKmsKey)
if [ "$keyMetadata" != "" ]; then
    chipertextBlob=$(aws kms encrypt --key-id alias/logglyKmsKey --plaintext "$logglyToken" --query CiphertextBlob --output text)
    accessRoleArn=$(aws iam get-role --role-name Cloudwatch-Full-Access-Loggly-Role --query Role.Arn --output text)

    logglyTokenParam="LogglyToken=${chipertextBlob}"
    serviceNameParam="ServiceName=${serviceName}"
    stackEnvParam="StackEnv=${stackEnv}"
    logGroupNameParam="LogGroupName=${stackEnv}-${serviceName}"
    accessRoleArnParam="AccessRoleArn=${accessRoleArn}"

    aws cloudformation deploy \
        --template-file loggly.yaml \
        --stack-name "$stackName" \
        --capabilities CAPABILITY_IAM \
        --parameter-overrides "$logGroupNameParam" 'LogglyHostName=logs-01.loggly.com' "$serviceNameParam" "$stackEnvParam" "$logglyTokenParam" "$accessRoleArnParam"
fi
