#!/bin/bash

source "$ACIDT_ROOT/lib/logutils.sh"

logdebug "Downloading connection $name into $directory directory, from $organization, region $region..."

if [[ -z "$name" ]]; then
    logfatal "required  -n Connector name for command download"
    exit 1
fi

CONNECTOR_RC=$(curl -s -H "Authorization: Bearer $token" -H "content-type:application/json" "https://connectors.googleapis.com/v1/projects/$organization/locations/$region/connections/$name" ) 
CONNECTOR_ERROR=$(echo $CONNECTOR_RC | jq ".error" 2> /dev/null)

if [ -z "$CONNECTOR_ERROR" ] || [ "$CONNECTOR_ERROR" == null ]; then
    echo $CONNECTOR_RC | jq "." > "$directory/$name.json" 
    echo "Connection $name succesfully downloaded."
else 
    logfatal "$CONNECTOR_RC"
    exit 1
fi

echo -e "\n"