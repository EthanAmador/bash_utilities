#!/bin/bash

source "$PWD/aws_check_credential.sh"
source "$PWD/validations.sh"

useJq

secret_name=$1
aws_profile=$2

isNullOrEmpty "$secret_name" "the secret name is required";
isNullOrEmpty "$aws_profile" "the profile is required";

checkCredentials



if [[ "$USE_JQ" == "true" ]]; then
    aws secretsmanager get-secret-value --secret-id $secret_name --profile $aws_profile | jq '.SecretString | fromjson'
else
    aws secretsmanager get-secret-value --secret-id $secret_name --profile $aws_profile | cat
fi