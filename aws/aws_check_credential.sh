#!/bin/bash

INI_FILE=~/.aws/credentials

function checkCredentials {
    echo "Cheking aws credential file.... 🫣"

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
    echo "ERROR: this profile $aws_profile does not exist in aws credentials file";
    exit 1
fi 

}







