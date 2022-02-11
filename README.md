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
