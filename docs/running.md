# Running Canyan Rating

In the [Getting Started](getting-started.md) section we introduced the different components of Canyan Rating. The ecosystem can be run locally, on virtual machines or in the cloud. We will present you here the two most common ways to do it.


## With Docker Compose
The easiest way of running Canyan Rating is with [Docker Compose](https://docs.docker.com/compose/). 


### Prerequisites

The prerequisites to run Canyan Rating with Docker Compose are the following:

* [Docker Engine](https://docs.docker.com/install/)
* [Docker Compose](https://docs.docker.com/compose/)

If you already don't have a machine running Docker and Docker Compose don't worry; it's a very easy and common software to install. Just follow the guides on the official [Docker website](https://www.docker.com). Docker can be easily run on your laptop regardless of the operating system you're using.


### Run

The [integration repository](https://github.com/canyanio/rating-integration) provides you the [docker-compose.yaml](https://github.com/canyanio/rating-integration/blob/master/docker-compose.yaml) needed run Canyan Rating in docker compose.

Start with cloning the repository locally:
```
git clone git@github.com:canyanio/rating-integration.git
```

The [Makefile](https://github.com/canyanio/rating-integration/blob/master/Makefile) provides you two shortcut commands:
`make start` and `make stop`.

As you can imagine `make start` will start Canyan Rating Engine in a docker compose environment exposing the needed two ports to interface with the Rating API and Agent.


## As local services

This is the "manual" way of installing the different components of Canyan Rating and running them on your machine.


### Prerequisites

* [MongoDB](https://www.mongodb.com/)
* [RabbitMQ](https://www.rabbitmq.com/)
* [Python](https://www.python.org/)


### Install Canyan Rating

It's recommended to use a [Python virtual environment](https://docs.python.org/3/library/venv.html) to isolate the installed packages from system site directories:
```
virtualenv -p python3 venv --no-site-packages
source venv/bin/activate
```

We will now use [pip](https://pypi.org/project/pip/) to install Canyan's packages from the [Python Package Index](https://pypi.org/):

```
pip install canyan-rating-api canyan-rating-agent canyan-rating-engine
```


### Run

For all the installed components you can run the command with the flag ```--help``` to have a full list of options and defaults that the command accepts.


#### API

Let's now run the API with the following command:
```
canyan-rating-api \
  -h 0.0.0.0 \
  -p 8000 \
  --mongodb-uri mongodb://localhost:27017
```
Please change the values of the options accordingly to your local setup.


#### Engine

The canyan-rating-engine is run with the following command:
```
canyan-rating-engine \
  --messagebus-uri pyamqp://user:password@localhost:5672// \
  --api-url http://localhost:8000
```

#### Agent

Now the agent can be run with the command:
```
canyan-rating-engine \
  -h 0.0.0.0 \
  -p 8080 \
  --messagebus-uri pyamqp://user:password@localhost:5672// \
  --api-url http://localhost:8000
```

Et voilà! You have now Canyan Rating up and running! 
