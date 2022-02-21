- [Authgear Helm chart](#authgear-helm-chart)
  * [Requirements](#requirements)
    + [Kubernetes requirements](#kubernetes-requirements)
    + [Storage requirements](#storage-requirements)
    + [CPU requirements](#cpu-requirements)
    + [Memory requirements](#memory-requirements)
    + [Database requirements](#database-requirements)
    + [Redis requirements](#redis-requirements)
    + [Elasticsearch requirements](#elasticsearch-requirements)
    + [Web browser requirements](#web-browser-requirements)
    + [Hardware requirements summary](#hardware-requirements-summary)
  * [How to install this Helm chart](#how-to-install-this-helm-chart)
    + [Preparation on your local machine](#preparation-on-your-local-machine)
    + [Obtain a domain name](#obtain-a-domain-name)
    + [Overview of the subdomains](#overview-of-the-subdomains)
    + [Provision the Kubernetes cluster](#provision-the-kubernetes-cluster)
    + [Provision the PostgreSQL database instance](#provision-the-postgresql-database-instance)
    + [Provision the Redis instance](#provision-the-redis-instance)
    + [Provision the SMTP server](#provision-the-smtp-server)
    + [Provision the NGINX ingress controller](#provision-the-nginx-ingress-controller)
    + [Provision the cert-manager](#provision-the-cert-manager)
    + [Create 2 namespaces](#create-2-namespaces)
    + [Create your own Helm chart](#create-your-own-helm-chart)
      - [Prepare the values.yaml](#prepare-the-valuesyaml)
      - [Create cert-manager HTTP01 issuer and DNS01 issuer](#create-cert-manager-http01-issuer-and-dns01-issuer)
      - [Run database migration](#run-database-migration)
      - [Create Elasticsearch index](#create-elasticsearch-index)
      - [Create deployment-specific authgear.secrets.yaml](#create-deployment-specific-authgearsecretsyaml)
      - [Create the "accounts" app](#create-the-accounts-app)
      - [Install your Helm chart](#install-your-helm-chart)
  * [How to upgrade Authgear](#how-to-upgrade-authgear)
  * [Helm chart values reference](#helm-chart-values-reference)
  * [Troubleshooting](#troubleshooting)
    + [Duplicate Ingress definition](#duplicate-ingress-definition)
  * [Appendices](#appendices)
    + [Customize the subdomain assignment](#customize-the-subdomain-assignment)

# Authgear Helm chart

> For developers who work on this Helm chart, please refer to the [DEVELOPER.md](./DEVELOPER.md)

## Requirements

This section includes information about the software and the hardware requirements to run Authgear on Kubernetes.

### Kubernetes requirements

The minimum supported version of Kubernetes is 1.19.

### Storage requirements

Authgear does not store persist data on disk.
It stores data in a PostgreSQL database and a Redis.

### CPU requirements

The CPU requirements depend on the number of users, workload and how active the users are.
There are 4 running pods in the basic setup.
Each pod has a limit of `500m` CPU.
2 Cores is recommended for the basic setup.

### Memory requirements

Each pod has a limit of `256MB` of memory.
1 GB of memory is recommended for the basic setup.

### Database requirements

PostgreSQL is the only supported database.
PostgreSQL 12 is recommended.
The PostgreSQL database must have the extension `pg_partman` installed, the version must be >= 4.0.

The database must have at least 5GB storage. The exact amount of storage depend on the number of users. About 100MB of storage is required to store 10,000 users.

Authgear stores its main data in a PostgreSQL database, and log data in another PostgreSQL database.
2 separate PostgreSQL databases are required.
It is strongly recommended that the PostgreSQL databases are not shared with other software.
The database account must have full access to the PostgreSQL database it connects to.
Authgear uses the `public` schema.

Do not make changes to the PostgreSQL databases, the schemas, the tables, the columns, or the rows.

### Redis requirements

Authgear stores user sessions and other ephemeral data in Redis.
The requirement is roughly 30kB per user.
The recommended version of Redis is >= 6.

### Elasticsearch requirements

Authgear portal provides the search feature with Elasticsearch.
A minimal setup of Elasticsearch consists of 3 Elasticsearch nodes.
Each node requires 1 Core of CPU and 2GB of memory.

### Web browser requirements

Authgear supports the following web browsers:

- Apple Safari
- Google Chrome
- Microsoft Edge
- Mozilla Firefox

The latest two major versions of the supported browsers are supported.

### Hardware requirements summary

- 2 Cores + 3 Cores of CPU
- 1 GB + 6 GB of memory
- PostgreSQL 12 with `pg_partman>=4.0`, at least 5GB storage
- Redis 6, with 30kB per user. 10000 users require 300MB.

## How to install this Helm chart

This section provides detailed steps on how to install this Helm chart.

### Preparation on your local machine

You need to install the following tools on your local machine.

- `kubectl` with a version matching the Kubernetes server version. For example, if the server is 1.21, then you should be using the latest version of `kubectl` 1.21.x.
- Helm v3. You should use the latest version.

### Obtain a domain name

You need to obtain a domain name from a Internet domain registrar.
If you already have a domain name, you can skip this step.

### Overview of the subdomains

This Helm chart assumes you have a apex domain dedicated to Authgear.
Assume your apex domain is `myapp.com`.

Here is the list of subdomain assignments.

```
Authgear App ID  Domain                        Description
accounts         accounts.myapp.com            The default endpoint of the app "accounts"
accounts         accounts.portal.myapp.com     The custom domain endpoint of the app "accounts"
                 portal.myapp.com              The Authgear portal endpoint
app1             app1.myapp.com                The default endpoint of the app "app1"
...
...
```

### Provision the Kubernetes cluster

If you have a Kubernetes cluster already, you can skip creating a new one.
Otherwise, follow the instructions from your cloud provider to create a new one.
Refer to the [Hardware requirements summary](#hardware-requirements-summary) to configure the node pool.

### Provision the PostgreSQL database instance

> It is strongly recommended that you set up an external production-ready PostgreSQL instance, instead of relying on a in-cluster PostgreSQL deployment like [bitnami/postgresql](https://hub.docker.com/r/bitnami/postgresql).

If you have a PostgreSQL database instance already, you can skip creating a new one.
Otherwise, follow the instructions from your cloud provider to create a new one.
Refer to the [Database requirements](#database-requirements) to configure the instance.

Create 2 PostgreSQL databases within the instance.
Create 1 PostgreSQL user for each PostgreSQL database. Make sure the PostgreSQL user has full access to the PostgreSQL database.
See [Database requirements](#database-requirements) for details.

### Provision the Redis instance

> It is strongly recommended that you set up an external production-ready Redis instance, instead of relying on a in-cluster Redis deployment like [bitnami/redis](https://hub.docker.com/r/bitnami/redis).

If you have a Redis instance already, you can skip creating a new one.
Otherwise, follow the instructions from your cloud provider to create a new one.
Refer to the [Redis requirements](#redis-requirements) to configure the instance.

You should reserve 1 Redis database for Authgear.

### Provision the SMTP server

If you have a SMTP server already, you can skip this step.
Otherwise, you can subscribe to services such as SendGrid.

### Provision the NGINX ingress controller

If the Kubernetes cluster has NGINX ingress controller set up already, you can skip this step.
Otherwise, you can use the Helm chart from [NGINX ingress controller](https://kubernetes.github.io/ingress-nginx/).

Note that Authgear expects the source IP of the incoming request to be correct.
The source IP is used in rate limiting.
If the source IP is incorrect, all requests are considered as coming the same source IP, making the limit being reached very soon.

One way correct the source IP is to set `externalTrafficPolicy` to `Local`.
The caveat of this approach is that if the request is routed to a node without any NGINX ingress controller running on,
the request is dropped.
The simplest way to ensure one NGINX ingress controller running on a node is to use [DaemonSet](https://github.com/kubernetes/ingress-nginx/blob/helm-chart-4.0.17/charts/ingress-nginx/values.yaml#L191).

You need to change your DNS record so that all traffic of your domain go to the Kubernetes cluster.

### Provision the cert-manager

[cert-manager](https://cert-manager.io/docs/) automates the process of obtaining, renewing and using TLS certificates issued by [Let's Encrypt](https://letsencrypt.org/).

If you decide to manage TLS certificates by yourself, you can skip this step.
Otherwise, you can use the Helm chart from [cert-manager](https://cert-manager.io/docs/installation/helm/)

Note that it is recommended that [you install the CRDs independent of the Helm chart](https://cert-manager.io/docs/installation/helm/#option-1-installing-crds-with-kubectl).
The advantage of this approach is that the CRD resources can stay intact even if you uninstall the Helm chart.

### Create 2 namespaces

It is recommended to create these 2 namespaces.

- `authgear`: Install the helm chart in this namespace
- `authgear-apps`: Authgear-generated resources are in this namespace.

### Create your own Helm chart

You need to create a few Kubernetes resources to support the Authgear Helm chart.
So the best way is to create your own Helm chart and make the Authgear Helm chart a dependency.

Create your Helm chart with `helm create authgear-deploy`.
Remove the generated boilerplate `.yaml` in the `templates/` directory.

#### Prepare the values.yaml

Refer to [Helm chart values reference](#helm-chart-values-reference) and
prepare the `./authgear-deploy/values.yaml`.

#### Create cert-manager HTTP01 issuer and DNS01 issuer

You need to create a [HTTP01 issuer](https://cert-manager.io/docs/configuration/acme/http01/) and
a [DNS01 issuer](https://cert-manager.io/docs/configuration/acme/dns01/) in both namespaces.
So there are 4 issuers you need to create in total.

#### Run database migration

```sh
$ docker run --rm -it quay.io/theauthgear/authgear-server authgear database migrate up \
  --database-url DATABASE_URL \
  --database-schema public
$ docker run --rm -it quay.io/theauthgear/authgear-portal authgear-portal database migrate up \
  --database-url DATABASE_URL \
  --database-schema public
```

#### Create Elasticsearch index

> This step is optional if you do not enable Elasticsearch.

```sh
$ docker run --rm -it quay.io/theauthgear/authgear-server authgear internal elasticsearch create-index \
  --elasticsearch-url ELASTICSEARCH_URL
```

#### Create deployment-specific authgear.secrets.yaml

Create a Secret that contains a `authgear.secrets.yaml` shared by all apps.

For example,

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: authgear-vendor-resources
type: Opaque
data:
  authgear.secrets.yaml: |-
    {{ include "authgear.authgearSecretsYAML" .Values.authgear | b64enc }}
```

#### Create the "accounts" app

Create the following directory structure

```sh
$ mkdir -p resources/authgear
```

Generate the `authgear.yaml`.
Save the output to `resources/authgear/authgear.yaml`.

```sh
$ docker run --rm -it quay.io/theauthgear/authgear-server authgear init authgear.yaml -o -
App ID (default 'my-app'): accounts
HTTP origin of authgear (default 'http://localhost:3000'): https://accounts.portal.myapp.com
```

Generate the `authgear.secrets.yaml`.
Save the output to `resources/authgear/authgear.secrets.yaml`.
You must remove the `"db"`, `"redis"` and `"elasticsearch"` items from it.
These items are included in the Secret you created in the previous step.

```sh
$ docker run --rm -it quay.io/theauthgear/authgear-server authgear init authgear.secrets.yaml -o -
Database URL (default 'postgres://postgres:postgres@127.0.0.1:5432/postgres?sslmode=disable'):
Database schema (default 'public'):
Elasticsearch URL (default 'http://localhost:9200'):
Redis URL (default 'redis://localhost'):
```

Create the "accounts" app

```sh
$ docker run -v "$PWD"/resources:/app/resources quay.io/theauthgear/authgear-portal authgear-portal internal setup-portal ./resources/authgear \
  --database-url DATABASE_URL \
  --database-schema public \
  --default-authgear-domain accounts.myapp.com \
  --custom-authgear-domain accounts.portal.myapp.com
```

#### Install your Helm chart

Install your helm chart with

```sh
helm install authgear-deploy ./authgear-deploy --namespace authgear --values ./authgear-deploy/values.yaml
```

## How to upgrade Authgear

If there are no breaking changes that require migration to be performed between the running version and the target version, an upgrade is as simple as setting `authgear.mainServer.image` and `authgear.portalServer.image` to a newer value.

If there are breaking changes, migration usually will be provided as a subcommand.

New features usually require database migration to add new tables and new columns.
You may need to [run database migration](#run-database-migration) before you run `helm upgrade`.
We try hard to make sure the modification to the database is backward-compatible,
which means older version of Authgear can run with a higher version of database schema.

## Helm chart values reference

|Name|Type|Required|Description|
|----|----|--------|-----------|
|`authgear.appNamespace`|String|No|The namespace to store Kubernetes resources created by Authgear. It is recommended to create a new namespace instead of reusing an existing one. You must create this namespace in advance. The default is `authgear-apps`.|
|`authgear.databaseURL`|String|Yes|The database URL for Authgear to store its main data|
|`authgear.databaseSchema`|String|Yes|The database schema for Authgear to store its main data|
|`authgear.redisURL`|String|Yes|The Redis URL for Authgear to store data with expiration, such as user sessions.|
|`authgear.logLevel`|String|No|The log level|
|`authgear.sentryDSN`|String|No|The sentry DSN to report error logs|
|`authgear.ingress.enabled`|Boolean|No|Whether to create Ingresses according to the convention of this Helm chart|
|`authgear.ingress.class`|String|No|The Ingress class. Only NGINX ingress controller is supported. The default is `nginx`|
|`authgear.certManager.enabled`|Boolean|No|Whether cert-manager was installed by you and is available for this Helm chart to use. The default is `true`|
|`authgear.certManager.issuer.dns01.name`|String|Depends|The name of the DNS01 issuer. It is required when cert-manager is enabled|
|`authgear.certManager.issuer.dns01.kind`|String|Depends|The kind of the DNS01 issuer. The default is `Issuer`|
|`authgear.certManager.issuer.dns01.group`|String|Depends|The group of the DNS01 issuer. The default is `cert-manager.io`|
|`authgear.certManager.issuer.http01.name`|String|Depends|The name of the HTTP01 issuer. It is required when cert-manager is enabled|
|`authgear.certManager.issuer.http01.kind`|String|Depends|The kind of the HTTP01 issuer. The default is `Issuer`|
|`authgear.certManager.issuer.http01.group`|String|Depends|The group of the HTTP01 issuer. The default is `cert-manager.io`|
|`authgear.baseHost`|String|Yes|The apex domain you assign to Authgear, for example `authgearapps.com`|
|`authgear.tls.wildcard.secretName`|String|No|The name of the Secret to store the wildcard TLS certificate `*.baseHost`|
|`authgear.tls.portal.secretName`|String|No|The name of the Secret to store the portal TLS certificate `portal.baseHost`|
|`authgear.tls.portalAuthgear.secretName`|String|No|The name of the Secret to store the portal Authgear TLS certificate `accounts.portal.baseHost`|
|`authgear.smtp.host`|String|Yes|The SMTP host|
|`authgear.smtp.port`|Integer|No|The SMTP port. The default is `587`|
|`authgear.smtp.mode`|String|No|The SMTP mode. Valid values are `normal` and `ssl`. When mode is `normal`, SSL usage is inferred from the port.|
|`authgear.smtp.username`|String|No|The SMTP username|
|`authgear.smtp.password`|String|No|The SMTP password|
|`authgear.elasticsearch.enabled`|Boolean|No|Whether elasticsearch was deployed by you separately and is available for Authgear to use. The default is `false`|
|`authgear.elasticsearch.url`|String|Depends|The URL to the elasticsearch|
|`authgear.twilio.accountSID`|String|Depends|The account SID of your Twilio subscription. It is required if you allow your users to authenticate with SMS. Either one of Twilio or Nexmo is enough|
|`authgear.twilio.authToken`|String|Depends|The auth token SID of your Twilio subscription.|
|`authgear.nexmo.apiKey`|String|Depends|The API key of your Nexmo subscription. It is required if you allow your users to authenticate with SMS. Either one of Twilio or Nexmo is enough|
|`authgear.nexmo.apiSecret`|String|Depends|The API secret of your Nexmo subscription.|
|`authgear.auditLog.enabled`|Boolean|No|Whether to make audit log available to view on the portal|
|`authgear.auditLog.cronjob.enabled`|Boolean|No|Whether to enable the cronjob to run `pg_partman` procedure to create partitions|
|`authgear.auditLog.cronjob.schedule`|String|No|The cron expression|
|`authgear.auditLog.databaseURL`|String|Yes|The database URL for Authgear to store its log data|
|`authgear.auditLog.databaseSchema`|String|Yes|The database schema for Authgear to store its log data|
|`authgear.analytic.enabled`|Boolean|No|Whether to collect analytic data. The default is `false`|
|`authgear.analytic.redisURL`|String|Yes|The Redis URL for Authgear to store analytic data|
|`authgear.mainServer.image`|String|Yes|The Authgear server image|
|`authgear.mainServer.resources`|Object|No|Kubernetes ResourceRequirements for the main server|
|`authgear.adminServer.resources`|Object|No|Kubernetes ResourceRequirements for the admin API  server|
|`authgear.resolverServer.resources`|Object|No|Kubernetes ResourceRequirements for the resolver server|
|`authgear.background.resources`|Object|No|Kubernetes ResourceRequirements for the background daemon|
|`authgear.portalServerProxy.image`|String|No|The Nginx sidecar image|
|`authgear.portalServer.image`|String|Yes|The Authgear portal server image|
|`authgear.portalServer.email.sender`|String|No|The email header Sender|
|`authgear.portalServer.email.replyTo`|String|No|The email header Reply-To|
|`authgear.portalServer.authgear.appID`|String|Yes|The app ID of the Authgear providing authentication for the portal server|
|`authgear.portalServer.authgear.clientID`|String|Yes|The client ID for the portal server to use Authgear|
|`authgear.portalServer.authgear.endpoint`|String|Yes|The endpoint of the Authgear used by the portal server|
|`authgear.portalServer.adminAPI.endpoint`|String|Yes|The static endpoint to the Admin API server. Normally this is an HTTP URL with cluster-local service name.|
|`authgear.portalServer.resources`|Object|No|Kubernetes ResourceRequirements for the portal server|
|`authgear.appCustomResources.path`|String|No|The custom resources directory applied to every app. It provides global theming for this particular deployment.|
|`authgear.appCustomResources.volume`|Object|No|Kubernetes Volume without the name field|
|`authgear.portalCustomResources.path`|String|No|The custom resources directory applied to the portal server. It provides theming for this particular deployment.|
|`authgear.portalCustomResources.volume`|Object|No|Kubernetes Volume without the name field|

## Troubleshooting

### Duplicate Ingress definition

When you upgrade the Helm chart from v5 to v6, the Ingress admission controller will complain about
duplicate Ingress definition. To resolve this problem, you have to manually delete the existing Ingress resources first. So the upgrade has downtime.

## Appendices

### Customize the subdomain assignment

This Helm chart has its own convention on the subdomain assignment and CANNOT be customized.
If you want to customize the assignment, you can set `authgear.ingress.enabled` to `false`.
You can then study the source code of this Helm chart, and create the Ingresses to suit your needs.
