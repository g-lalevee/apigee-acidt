#!/bin/bash

source "$AINTDEPLOYER_ROOT/lib/logutils.sh"

logdebug "Deleting Integration $name (all versions) in $organization, region $region..."

#-----------------------------------------------------------
# Progress bar functions

preparebar() {
# $1 - bar length
# $2 - bar char
    barlen=$1
    barspaces=$(printf "%*s" "$1")
    barchars=$(printf "%*s" "$1" | tr ' ' "$2")
}

progressbar() {
# $1 - number (-1 for clearing the bar)
# $2 - max number
    if [ $1 -eq -1 ]; then
        printf "\r  $barspaces\r"
    else
        barch=$(($1*barlen/$2))
        barsp=$((barlen-barch))
        printf "\r[%.${barch}s%.${barsp}s]\r" "$barchars" "$barspaces"
    fi
}

#-----------------------------------------------------------

if [[ -z "$name" ]]; then
    logfatal "required  -n Integration name for command download"
    exit 1
fi

# Retrieve Integration version list from Integration Name

logdebug "1-Retrieve list of versions from integration $name"

VERSION_LIST=$(curl -s -H "Authorization: Bearer $token" -H "content-type:application/json" "https://$region-integrations.googleapis.com/v1/projects/$organization/locations/$region/products/apigee/integrations/$name/versions" | jq -r ".integrationVersions[].name" 2>/dev/null)

if [ -z "$VERSION_LIST" ]; then
    logfatal "Cannot retrieved integration named $name."
    exit 1
fi

# Get number of versions
preparebar 10 "#"
VERSION_LIST_SIZE=$(echo $VERSION_LIST | wc -w)
VERSION_NUM=0

logdebug "2-Delete (archive) all $VERSION_LIST_SIZE retrieved versions"
for VERSION in $VERSION_LIST
do
    ((VERSION_NUM++))
    VERSION=$(echo $VERSION |  cut -d '/' -f 10)
    ARCHIVE_RC=$(curl  -s -L -X POST -H "Authorization: Bearer $token" -H "content-type:application/json" "https://$region-integrations.googleapis.com/v1/projects/$organization/locations/$region/products/apigee/integrations/$name/versions/$VERSION:archive")
    if  [ "$ARCHIVE_RC" == "{}" ]; then
        progressbar $VERSION_NUM $VERSION_LIST_SIZE
    else 
        logfatal "$ARCHIVE_RC"
        exit 1
    fi
done

echo "Integration $name ($(echo $VERSION_LIST_SIZE | xargs echo -n) versions) succesfully deleted."
echo -e "\n"
