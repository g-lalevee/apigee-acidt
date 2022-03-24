[![Generic badge](https://img.shields.io/badge/status-work--in--progress-important.svg)](https://shields.io/) ![GitHub last commit](https://img.shields.io/github/last-commit/g-lalevee/Ain-t-deployment-tool) 


# Apigee acidt 
###### **A**pigee **Int**egration **Deployment Tool** 
***

**This is not an official Google product.**<BR>This implementation is not an official Google product, nor is it part of an official Google product. Support is available on a best-effort basis via GitHub.

***

**:warning: Work in progress  :construction:**

Apigee acidt - aka Apigee Connection & Integration Deployment Tool - lets you deploy Apigee Connecyions and Integration configuration files. <BR>More about [Apigee Integration](https://cloud.google.com/apigee/docs/api-platform/integration/what-is-apigee-integration).

Acidt can be used as a commandline tool. To use it as a CLI you can add it to your path:


```sh
PATH="$PATH:$PWD/bin"
```

## General Usage

```text
$ acidt help
usage: acidt OBJECT COMMAND -o ORG -t TOKEN [options]

Apigee acidt utility.

Objects:
  connection
  integration

Commands:
  download
  create
  list
  publish (integration only)
  delete

Options:

-d,--directory, path to the connection or integration configuration file to be created (download)
-f,--file, connection or integration configuration file name (create)
-n,--name, connection or integration name 
-o,--organization, Apigee organization name (=GCP project id or GCP project number)
-r, --region, Apigee connection or integration region
-t,--token, GCP token 
--debug, show verbose debug output
```

## CLI Examples

The following examples show acidt commands as a CLI.


First, export following environment variables:

```sh
export TOKEN=$(gcloud auth print-access-token)
export APIGEE_ORG=<your-apigee-org>
```

### Apigee integration

1. List all Apigee Integrations in us region us (default)

```sh
$ acidt integration list -o $APIGEE_ORG -t $TOKEN 
```
<BR>

2. Download lastest version of an Integration

```sh
$ acidt integration download -o $APIGEE_ORG -t $TOKEN --name myIntegration --directory ./sample
```
<BR>

3. Create a new Integration (or a new version of a existing one)

```sh
$ acidt integration create  -o $APIGEE_ORG -t $TOKEN --name myIntegration --file ./sample/integration.json 
 ```
<BR>

4. Publish (Deploy) lastest version of an Integration

```sh
$ acidt integration publish  -o $APIGEE_ORG -t $TOKEN --name myIntegration --debug
 ```
 <BR>

5. Delete an Integration (all versions)

```sh
$ acidt integration delete  -o $APIGEE_ORG -t $TOKEN --name myIntegration
 ```
 <BR>

### Apigee Connection

1. List all Connections in region europe-west1, in debug mode 

```sh
$ acidt connection list -o $APIGEE_ORG -t $TOKEN -r europe-west1 --debug
```
<BR>

2. Download Connection configuration file from a Connection, into ./sample directory

```sh
$ acidt connection download -o $APIGEE_ORG -t $TOKEN --name myConnection --directory ./sample
```
<BR>

3. Create a new Connection from configuration file

```sh
$ acidt connection create -o $APIGEE_ORG -t $TOKEN --name myConnection2 --file ./sample/connection.json 
 ```
<BR>

4. Delete a Connection 

```sh
$ acidt connection delete -o $APIGEE_ORG -t $TOKEN --name myConnection
 ```
 <BR>
