#!/bin/bash

source "$ACIDT_ROOT/lib/logutils.sh"

logdebug "Deleting Connection $name in $organization, region $region..."



if [[ -z "$name" ]]; then
    logfatal "required  -n Integration name for command download"
    exit 1
fi

# Retrieve Integration version list from Integration Name

logdebug "1-Retrieve list of versions from integration $name"

if [[ -z "$name" ]]; then
    logfatal "required  -n Connection name for command delete"
    exit 1
fi

if [[ -z "$region" ]]; then
    logfatal "required  -r Region name for command delete"
    exit 1
fi

CONNECTION_RC=$(curl -s -X DELETE -H "Authorization: Bearer $token" -H "content-type:application/json" "https://connectors.googleapis.com/v1/projects/$organization/locations/$region/connections/$name" ) 

CONNECTION_ERROR=$(echo $CONNECTION_RC | jq -r ".error" 2> /dev/null)

if [ -z "$CONNECTION_ERROR" ] || [ "$CONNECTION_ERROR" == null ]; then
    echo "Connection $name succesfully deleted."
else 
    logfatal "$CONNECTION_RC"
    exit 1
fi

echo -e "\n"
