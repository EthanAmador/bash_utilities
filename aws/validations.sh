#!/bin/bash

function isNullOrEmpty { 
    if [ -z "$1" ]; then 
        echo "ERROR: $2";
        exit 1;
    fi
}

function exitsFile {
    if ! [ -f "$1" ]; then
        echo "this file [$1] does not exist."
        exit 1;
    fi
}

function useJq {
    jqVersion=$(jq --version)
    jqRegex=^jq-[0-9]{1,}.[0-9]{1,}$ 
    if [[ $jqVersion =~ $jqRegex ]]; then
        USE_JQ="true";
    fi
}

function isValidJson {
    if [[ "$USE_JQ" == "true" ]]; then 
      if ! jq empty $1; then
            echo "This file [$1] is invalid"
            exit 1;
        fi
    else
         echo "For better use, install jq https://stedolan.github.io/jq/download/"
    fi
}