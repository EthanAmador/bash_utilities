#!/bin/bash

environment=$1

if [ "$environment" != "test" ] && [ "$environment" != "demo" ]; then
    echo "ERROR: You need to pass as parameter the name of the environment (test or demo) to run this script.";
    exit 1
fi

if [ "$environment" = "test" ]; then 
    aws_profile="test"
    aws_region="us-east-1"
elif [ "$environment" = "demo" ]; then 
    aws_profile="demo-bastion"
    aws_region="us-east-2"
fi

INI_FILE=~/.aws/credentials

echo "Read aws credential file.... 🫣"

while IFS=' = ' read key value
do
    if [[ $key == \[*] ]]; then
        section=$key
    elif [[ $value ]] && [[ $section == "[${aws_profile}]" ]]; then
        if [[ $key == 'aws_access_key_id' ]]; then
            AWS_ACCESS_KEY_ID=$value
        elif [[ $key == 'aws_secret_access_key' ]]; then
            AWS_SECRET_ACCESS_KEY=$value
        fi
    fi
done < $INI_FILE

if [ -z "$AWS_ACCESS_KEY_ID" ] || [ -z "$AWS_SECRET_ACCESS_KEY" ]; then 
    echo "ERROR: profile does not exist in aws credentials file";
    exit 1
fi 

echo "Set default aws credential....🔑"
{
    aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID" && aws configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY" && aws configure set region "$aws_region"  && aws configure set output "json"
} ||
{
    echo "ERROR: try to assing default credential 💥"
    exit 1;
}

# echo "Set default values to serverless config....🔑" 
# {
#     serverless config credentials --provider aws --key "$AWS_ACCESS_KEY_ID" --secret "$AWS_SECRET_ACCESS_KEY" --overwrite 
# } ||
# {
#     echo "ERROR: try to assing default credential in serverless 💥"
#     exit 1;
# }


