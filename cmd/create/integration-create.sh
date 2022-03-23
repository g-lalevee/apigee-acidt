#!/bin/bash

source "$AINTDEPLOYER_ROOT/lib/logutils.sh"

logdebug "Creating Integration $name in $organization, region $region, from file $file..."

if [[ -z "$name" ]]; then
    logfatal "required  -n Integration name for command create"
    exit 1
fi

if [[ -z "$file" ]]; then
    logfatal "required  -f Integration file name for command create"
    exit 1
fi

CREATE_RC=$(curl  -s -L -X POST -H "Authorization: Bearer $token" -H "content-type:application/json" "https://$region-integrations.googleapis.com/v1/projects/$organization/locations/$region/products/apigee/integrations/$name/versions" --data-binary "@$file" )
CREATE_INTEGRATION=$(echo $CREATE_RC | jq -r ".name" 2>/dev/null )

if [ -z "$CREATE_INTEGRATION" ] || [ "$CREATE_INTEGRATION" == null ]; then
    logfatal "$CREATE_RC"
    exit 1
else 
    VERSION=$(echo $CREATE_INTEGRATION |  cut -d '/' -f 10)
    echo "Integration $name, version $VERSION, succesfully created."
fi
echo -e "\n"