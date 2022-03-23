[![Generic badge](https://img.shields.io/badge/status-work--in--progress-green.svg)](https://shields.io/) 


# Ain't Deployment Tool 

***

**This is not an official Google product.**<BR>This implementation is not an official Google product, nor is it part of an official Google product. Support is available on a best-effort basis via GitHub.

***

**:warning: Work in progress  :construction:**

Ain't Deployment Tool - aka A(pigee) Int(egration) Deployment Tool - lets you deploy Apigee Integration configuration file. <BR>More about [Apigee Integration](https://cloud.google.com/apigee/docs/api-platform/integration/what-is-apigee-integration).

Aintdeployer can be used as a commandline tool. To use it as a CLI you can add it to your path:


```sh
PATH="$PATH:$PWD/bin"
```

## General Usage

```text
$ aintdeployer help
usage: AINTDEPLOYER COMMAND  -o ORG -t TOKEN [options]

Apigee AINTDEPLOYER utility.

Commands:
download
create
list
publish
delete

Options:

-d,--directory, path to the integration configuration file to be created (download)
-f,--file, integration configuration file name (create)
-n,--name, integration name 
-o,--organization, Apigee organization name (GCP project id or GCP project number)
-r,--region, Apigee Integration target region
-t,--token, GCP token 
--debug, show verbose debug output
```

## CLI Examples

The following examples show aintdeployer commands as a CLI.


First, export following environment variables:

```sh
export TOKEN=$(gcloud auth print-access-token)
export APIGEE_ORG=<your-apigee-org>
````

1. List all Apigee Integrations

```sh
$  ./bin/aintdeployer list -o $APIGEE_ORG -t $TOKEN 
```

2. Download lastest version of an Apigee Integration

```sh
$ ./bin/aintdeployer download -o $APIGEE_ORG -t $TOKEN --name myIntegration
```

3. Create a new Apigee Integration (or a new version of a existing one)

```sh
$ ./bin/aintdeployer create  -o $APIGEE_ORG -t $TOKEN --name my-test --file ./integration/new.json 
 ```

4. Publish (Deploy) lastest version of an Apigee Integration

```sh
$ ./bin/aintdeployer publish  -o $APIGEE_ORG -t $TOKEN --name my-test 
 ```

5. Delete an Apigee Integration (all versions)

```sh
$ ./bin/aintdeployer delete  -o $APIGEE_ORG -t $TOKEN --name my-test
 ```
