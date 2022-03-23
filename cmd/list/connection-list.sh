#!/bin/bash

source "$AINTDEPLOYER_ROOT/lib/logutils.sh"

logdebug "Extracting Connection list from $organization, region $region..."

CONNECTOR_LIST_RC=$(curl -s -H "Authorization: Bearer $token" -H "content-type:application/json" "https://connectors.googleapis.com/v1/projects/$organization/locations/$region/connections" )
CONNECTOR_LIST=$(echo $CONNECTOR_LIST_RC | jq -r ".connections" 2>/dev/null )

if [ -z "$CONNECTOR_LIST" ] || [ "$CONNECTOR_LIST" == null ]; then
    logfatal "$CONNECTOR_LIST_RC"
    exit 1
else 
    CONNECTOR_LIST_SIZE=$(echo $CONNECTOR_LIST_RC | jq -r ".connections | length" 2>/dev/null )
    echo $CONNECTOR_LIST_RC | jq -r '.'
    echo "Connection list ($CONNECTOR_LIST_SIZE connections) succesfully retrieved."
fi

echo -e "\n"



