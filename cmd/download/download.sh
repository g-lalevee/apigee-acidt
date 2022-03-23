#!/bin/bash

source "$AINTDEPLOYER_ROOT/lib/logutils.sh"

logdebug "Downloading integration $name into $directory, from $organization, region $region..."

if [[ -z "$name" ]]; then
    logfatal "required  -n Integration name for command download"
    exit 1
fi

VERSION=$(curl -s -H "Authorization: Bearer $token" -H "content-type:application/json" "https://$region-integrations.googleapis.com/v1/projects/$organization/locations/$region/products/apigee/integrations/$name/versions" ) 
PROJECT_URI=$(echo $VERSION | jq -r ".integrationVersions[0].name" 2>/dev/null )

if [ -z "$PROJECT_URI" ] || [ "$PROJECT_URI" == null ]; then
  if  [ "$VERSION" == "{}" ]; then
    logfatal "Integration not found."
  else 
    logfatal "$VERSION"
  fi
  exit 1
else
  PROJECT_URI=$(echo $VERSION | jq -r ".integrationVersions[0].name")
  VERSION=$(echo $PROJECT_URI |  cut -d '/' -f 10)
  curl -s -H "Authorization: Bearer $token" -H "content-type:application/json" \
    "https://$region-integrations.googleapis.com/v1/$PROJECT_URI:download" | jq ".content | fromjson" > "$directory/$name-$VERSION.json"
  echo "Integration $name, version $VERSION, succesfully downloaded."
fi
echo -e "\n"


