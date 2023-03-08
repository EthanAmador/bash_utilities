#!/bin/bash

source "$PWD/aws_check_credential.sh"
source "$PWD/validations.sh"

useJq

secret_name=$1
aws_profile=$2
file_path=$3


isNullOrEmpty "$secret_name" "the secret name is required";
isNullOrEmpty "$aws_profile" "the profile is required";
exitsFile $file_path
isValidJson $file_path
checkCredentials

if [[ "$USE_JQ" == "true" ]]; then
    aws secretsmanager put-secret-value --secret-id $secret_name --secret-string file://$file_path --profile $aws_profile | jq .
else
    aws secretsmanager put-secret-value --secret-id $secret_name --secret-string file://$file_path --profile $aws_profile | cat
fi
