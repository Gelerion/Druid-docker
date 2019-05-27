# Druid Docker

Creates fully configured and ready to use druid cluster, which uses `s3` as a deep storage and `mysql` as a metadata store.

## Running
You can start everything with this command:

> docker-compose up

All environment variables `${}` in docker compose file are substituted by values defined in `.env` file

By default it ships with `0.14.1-incubating` version. If you are willing to change the version use this command:

> docker-compose build --build-arg DRUID_VERSION="your-version"

This starts a Druid cluster including:
- **Zookeeper**
	- zoonavigator-web - Web interface for managing configuration stored whithin the ZooKeeper. Runs on `8000` port.
	- zoonavigator-api - Just a backend to serve zoonavigator-web requests. 
	- zookeeper - ZooKeeper itself. Runs on `2181` port.
- **S3**
	- s3-minio - An open source service to mimic S3 API and behavior. Runs on `9000` port.
- **Mysql**
	- mysql - Offical mysql image, 5.7.26 version is used. Runs on `3306` port.

---
**The most useful services:**
1. Druid Management UI - [http://localhost:8080](http://localhost:8080)
2. S3 Minio UI - [http://localhost:9000](http://localhost:9000)  
 access - `druid-s3-access`  
 secret -`druid-s3-secret`
3. Zookeeper Web UI - [http://localhost:8000](http://localhost:8000)  
connection string: `zookeeper:2181`
4. Mysql connection `jdbc:mysql://localhost:3306/druid`  
user name - `druid`  
password - `diurd` (root password - `1234`)
---


## Druid Cluster 

 * **coordinator** runs on `8081` port

The coordinator is primarily responsible for segment management and distribution. More specifically, the Druid Coordinator process communicates to Historical processes to load or drop segments based on configurations. The Druid Coordinator is responsible for loading new segments, dropping outdated segments, managing segment replication, and balancing segment load.

 * **broker** runs on `8082` port

The Broker is the process to route queries to if you want to run a distributed cluster. It understands the metadata published to ZooKeeper about what segments exist on what processes and routes queries such that they hit the right processes. This process also merges the result sets from all of the individual processes together. On start up, Historical processes announce themselves and the segments they are serving in Zookeeper.

* **historical** runs on `8083` port

Each Historical process maintains a constant connection to Zookeeper and watches a configurable set of Zookeeper paths for new segment information. Historical processes do not communicate directly with each other or with the Coordinator processes but instead rely on Zookeeper for coordination.

* **overlord** runs on `8090` port

The Overlord process is responsible for accepting tasks, coordinating task distribution, creating locks around tasks, and returning statuses to callers. Overlord can be configured to run in one of two modes - local or remote. In local mode Overlord is also responsible for creating Peons for executing tasks. When running the Overlord in local mode, all MiddleManager and Peon configurations must be provided as well. Our cluster is configured to run in remote mode.

* **middlemanager** runs on `8091` port

The MiddleManager process is a worker process that executes submitted tasks. Middle Managers forward tasks to Peons that run in separate JVMs. 

* **router** runs on `8080` port

In addition to query routing, the Router also runs the Druid Console, a management UI for datasources, segments, tasks, data processes (Historicals and MiddleManagers), and coordinator dynamic configuration. The user can also run SQL and native Druid queries within the console.

## Usage