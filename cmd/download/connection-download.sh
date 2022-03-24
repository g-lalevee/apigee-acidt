#!/bin/bash

source "$ACIDT_ROOT/lib/logutils.sh"

logdebug "Downloading connection $name into $directory directory, from $organization, region $region..."

if [[ -z "$name" ]]; then
    logfatal "required  -n Connection name for command download"
    exit 1
fi

if [[ -z "$region" ]]; then
    logfatal "required  -r Region name for command delete"
    exit 1
fi

CONNECTION_RC=$(curl -s -H "Authorization: Bearer $token" -H "content-type:application/json" "https://connectors.googleapis.com/v1/projects/$organization/locations/$region/connections/$name" ) 
CONNECTION_ERROR=$(echo $CONNECTION_RC | jq ".error" 2> /dev/null)

if [ -z "$CONNECTION_ERROR" ] || [ "$CONNECTION_ERROR" == null ]; then
    echo $CONNECTION_RC | jq "." > "$directory/$name.json" 
    echo "Connection $name succesfully downloaded."
else 
    logfatal "$CONNECTION_RC"
    exit 1
fi

echo -e "\n"