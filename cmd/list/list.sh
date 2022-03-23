#!/bin/bash

source "$AINTDEPLOYER_ROOT/lib/logutils.sh"


INTEGRATION_LIST_RC=$(curl -s -H "Authorization: Bearer $token" -H "content-type:application/json" "https://us-integrations.googleapis.com/v1/projects/$organization/locations/us/products/apigee/integrations" )

INTEGRATION_LIST=$(echo $INTEGRATION_LIST_RC | jq -r ".integrations" 2>/dev/null )

if [ "$INTEGRATION_LIST" == null ]; then
    logfatal "$INTEGRATION_LIST_RC"
else 
    INTEGRATION_LIST_SIZE=$(echo $INTEGRATION_LIST_RC | jq -r ".integrations | length" 2>/dev/null )
    echo $INTEGRATION_LIST_RC | jq -r '.'
    echo "List of Integrations ($INTEGRATION_LIST_SIZE integrations) succesfully retrieved."
fi

echo -e "\n"
