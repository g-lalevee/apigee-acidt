#!/bin/bash

source "$ACIDT_ROOT/lib/logutils.sh"

logdebug "Creating Connection $name in $organization, region $region, from file $file..."

if [[ -z "$name" ]]; then
    logfatal "required  -n Connection name for command create"
    exit 1
fi

if [[ -z "$file" ]]; then
    logfatal "required  -f Connection file name for command create"
    exit 1
fi

CREATE_RC=$(curl  -s -L -X POST -H "Authorization: Bearer $token" -H "content-type:application/json" "https://connectors.googleapis.com/v1/projects/$organization/locations/$region/connections?connectionId=$name" --data-binary "@$file" )
CREATE_CONNECTION=$(echo $CREATE_RC | jq -r ".name" 2>/dev/null )

if [ -z "$CREATE_CONNECTION" ] || [ "$CREATE_CONNECTION" == null ]; then
    logfatal "$CREATE_RC"
    exit 1
else 
    echo "Connection $name succesfully created."
fi
echo -e "\n"