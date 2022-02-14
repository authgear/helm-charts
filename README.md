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
  * [Helm chart values reference](#helm-chart-values-reference)

# Authgear Helm chart

> For developers who work on this Helm chart, please refer to the [DEVELOPER.md](./DEVELOPER.md)

## Requirements

This section include information about the software and the hardware requirements to run Authgear on Kubernetes.

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
