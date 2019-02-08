# `consultr` Docker instructions

This repository contains Docker instructions for a Shiny server that runs statistical consulting apps from the [`consultr` package](https://github.com/clayford/consultr/).

A built version of the container is hosted on [Docker Hub](https://hub.docker.com/r/somrc/consultr). 

To run the container locally:

```
docker pull somrc/consultr
```

```
docker run -d -p 80:80 somrc/consultr
```

Alternatively, you can build the container locally based on the `Dockerfile` in this repository:

```
git clone https://github.com/clayford/consultr.git
```

```
cd consultr/docker
```

```
docker build -t consultr .
```

```
docker run -d -p 80:80 consultr
```
