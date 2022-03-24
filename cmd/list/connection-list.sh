#!/bin/bash

source "$ACIDT_ROOT/lib/logutils.sh"

logdebug "Extracting Connection list from $organization, region $region..."

CONNECTION_LIST_RC=$(curl -s -H "Authorization: Bearer $token" -H "content-type:application/json" "https://connectors.googleapis.com/v1/projects/$organization/locations/$region/connections" )
CONNECTION_LIST=$(echo $CONNECTION_LIST_RC | jq -r ".connections" 2>/dev/null )

if [ "$CONNECTION_LIST_RC" != "{}" ] && { [ -z "$CONNECTION_LIST" ] || [ "$CONNECTION_LIST" == null ]; }; then
    logfatal "$CONNECTION_LIST_RC"
    exit 1
else 
    CONNECTION_LIST_SIZE=$(echo $CONNECTION_LIST_RC | jq -r ".connections | length" 2>/dev/null )
    echo $CONNECTION_LIST_RC | jq -r '.'
    echo "Connection list ($CONNECTION_LIST_SIZE connections) succesfully retrieved."
fi

echo -e "\n"



