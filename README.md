# Apache Zeppelin Docker container

### [Docker Hub for this image](https://hub.docker.com/r/kduda/zeppelin/)

#### Supported tags and respective `Dockerfile` links
* [`0.7.1`, `latest`  (0.7.1/Dockerfile)](https://github.com/DudaKamil/docker-zeppelin/blob/master/Dockerfile) 

This image exposes `8080, 8443` ports.

#### How to use this image
### start standalone container and link with existing `spark-master`
`$ docker run --network spark-master-network -p 8080:8080 -p 9443:8443 --name docker-zeppelin --link some-spark-master kduda/zeppelin:latest`

### start with a spark cluster `docker-compose up -d`
* [`spark-zeppelin/docker-compose.yml`](https://github.com/DudaKamil/docker-spark/blob/master/spark-zeppelin/docker-compose.yml) - Zeppelin with Spark Master and 4 workers
