#!/bin/bash

source "$ACIDT_ROOT/lib/logutils.sh"

logdebug "Extracting Integration list from $organization, region $region..."

INTEGRATION_LIST_RC=$(curl -s -H "Authorization: Bearer $token" -H "content-type:application/json" "https://$region-integrations.googleapis.com/v1/projects/$organization/locations/$region/products/apigee/integrations" )
INTEGRATION_LIST=$(echo $INTEGRATION_LIST_RC | jq -r ".integrations" 2>/dev/null )


if [ "$INTEGRATION_LIST_RC" != "{}" ] && { [ -z "$INTEGRATION_LIST" ] || [ "$INTEGRATION_LIST" == null ]; }; then
    logfatal "$INTEGRATION_LIST_RC"
    exit 1
else 
    INTEGRATION_LIST_SIZE=$(echo $INTEGRATION_LIST_RC | jq -r ".integrations | length" 2>/dev/null )
    echo $INTEGRATION_LIST_RC | jq -r '.'
    echo "Integration list ($INTEGRATION_LIST_SIZE integrations) succesfully retrieved."
fi

echo -e "\n"
