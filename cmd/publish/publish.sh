#!/bin/bash

source "$AINTDEPLOYER_ROOT/lib/logutils.sh"

if [[ -z "$name" ]]; then
    logfatal "required  -n Integration name for command download"
    exit 1
fi


VERSION=$(curl -s -H "Authorization: Bearer $token" -H "content-type:application/json" "https://$region-integrations.googleapis.com/v1/projects/$organization/locations/$region/products/apigee/integrations/$name/versions" ) 
PROJECT_URI=$(echo $VERSION | jq -r ".integrationVersions[0].name" 2>/dev/null )

if [ "$PROJECT_URI" == null ]; then
  if  [ "$VERSION" == "{}" ]; then
    logfatal "Integration not found"
  else 
    logfatal "$VERSION"
  fi
  exit 1
else
  PROJECT_URI=$(echo $VERSION | jq -r ".integrationVersions[0].name")
  VERSION=$(echo $PROJECT_URI |  cut -d '/' -f 10)
  DEPLOY_RC=$(curl -s -X POST -H "Authorization: Bearer $token" -H "content-type:application/json" "https://$region-integrations.googleapis.com/v1/$PROJECT_URI:publish")
  if  [ "$DEPLOY_RC" == "{}" ]; then
    echo "Integration $name, version $VERSION, succesfully published."
  else 
    logfatal "$DEPLOY_RC"
    exit 1
  fi
fi
echo -e "\n"