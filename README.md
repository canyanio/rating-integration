# Canyan Rating

Canyan Rating is an open source real-time highly scalable rating system. It is composed of an Agent Service, an API, and a Rating Engine.

The rating system is a critical component in any business, especially when real-time features are a strict requirement to ensure business continuity and congruence of transactions. Any compromise to availability, integrity, and authentication in the billing system makes a huge impact on the services provided.

Canyan aims to address these challenges with a cloud-native scalable solution, easily deployable and easily usable. It has been designed to work atomically ensuring the system status is always consistent, reproducible and coherent. Asynchronous processing of no real-time, consolidation events, prioritization, and time-boxed tasks provide the basics to ensure lightning-fast transaction processing without compromises.

Ease of use is addressed with comprehensive documentation, examples and high-quality software (see the test coverage badges).

Canyan Rating is designed as a microservice architecture and comprises [several repositories](https://github.com/canyanio). Its components are stateless and easily deployable via containers on-premises or in the cloud. 

This repository contains the Canyan Rating Integration documentation, tests and lab.

![Canyan logo](https://canyanio.github.io/rating-integration/canyan-logo.png) 


## Components

Canyan Rating is designed as a microservice architecture and comprises [several repositories](https://github.com/canyanio). Its components are stateless, highly scalable and easily deployable via containers on-premises or in the cloud. 

### Agent

[![Build Status](https://gitlab.com/canyan/rating-agent/badges/master/pipeline.svg)](https://gitlab.com/canyan/rating-agent/pipelines) [![codecov](https://codecov.io/gh/canyanio/rating-agent/branch/master/graph/badge.svg)](https://codecov.io/gh/canyanio/rating-agent) [![Docker pulls](https://img.shields.io/docker/pulls/canyan/rating-agent.svg?maxAge=3600)](https://hub.docker.com/repository/docker/canyan/rating-agent)

The Agent component is a bidirectional component that interfaces with external systems that needs to rate it's traffic and services. 
It is written in [Python](https://www.python.org/) programming language, documented and highly covered with tests (see badges above).

### HEP Agent

[![Build Status](https://gitlab.com/canyan/rating-agent-hep/badges/master/pipeline.svg)](https://gitlab.com/canyan/rating-agent-hep/pipelines) [![codecov](https://codecov.io/gh/canyanio/rating-agent-hep/branch/master/graph/badge.svg)](https://codecov.io/gh/canyanio/rating-agent-hep) [![Docker pulls](https://img.shields.io/docker/pulls/canyan/rating-agent-hep.svg?maxAge=3600)](https://hub.docker.com/repository/docker/canyan/rating-agent-hep)

This Agent component uses the [HEP/EEP Encapsulation Protocol](https://github.com/sipcapture/hep)
for packet capture and mirroring of RTC solutions which allows for a transparent and unobtrusive rating solution. 
It is written in [Go](https://golang.org/) programming language, documented and highly covered with tests (see badges above).

### API

[![Build Status](https://gitlab.com/canyan/rating-api/badges/master/pipeline.svg)](https://gitlab.com/canyan/rating-api/pipelines) [![codecov](https://codecov.io/gh/canyanio/rating-api/branch/master/graph/badge.svg)](https://codecov.io/gh/canyanio/rating-api) [![Docker pulls](https://img.shields.io/docker/pulls/canyan/rating-api.svg?maxAge=3600)](https://hub.docker.com/repository/docker/canyan/rating-api)

The API is the interface towards the database, it is scalable and used by the internal and external components.
It is written in [Python](https://www.python.org/) programming language, fully asynchronous and very fast. It is documented and highly covered with tests (see badges above).

### Engine

[![Build Status](https://gitlab.com/canyan/rating-engine/badges/master/pipeline.svg)](https://gitlab.com/canyan/rating-engine/pipelines) [![codecov](https://codecov.io/gh/canyanio/rating-engine/branch/master/graph/badge.svg)](https://codecov.io/gh/canyanio/rating-engine) [![Docker pulls](https://img.shields.io/docker/pulls/canyan/rating-engine.svg?maxAge=3600)](https://hub.docker.com/repository/docker/canyan/rating-engine)

The heavy lifting and real time calculation is done by the Rating Engine component which is stateless and highly scalable.
It is written in [Python](https://www.python.org/) programming language, documented and covered with tests (see badges above).


## Getting started

To start using Canyan Rating, we recommend that you begin with the Getting started
section in [the Canyan Rating documentation](https://canyanio.github.io/rating-integration/).


## Running

This repository contains several docker-compose files with the Canyan Rating and its dependencies (MongoDB and RabbitMQ) alongside with a Kamailio, OpenSIPS, Carrier (SIPP container) and the CanyanTester tool.

It is used for integration examples with major open-source SIP routing software.

You can easily run everything via the provided [docker-compose](docker-compose.yaml) file with:
```
$ make docker-start
```
If you're not familiar with docker-compose read [the documentation](https://docs.docker.com/compose/) on the official docker website.

You can also install and run every single component as separate service but it's outside of the scope of this lab and the examples provided.

For "transparent" integration with your services, you can use the HEP protocol with the [Canyan Rating HEP Agent](https://github.com/canyanio/rating-agent-hep). The HEP Agent repository contains examples and tests for integrating Canyan Rating via HEP/EEP protocol so refer to [the Canyan Rating documentation](https://canyanio.github.io/rating-integration/) for that use case.


## Contributing

We welcome and ask for your contribution. If you would like to contribute to Canyan Rating, please read our guide on how to best get started [contributing code or documentation](contributing).


## License

Canyan is licensed under the GNU General Public License version 3. See
[LICENSE](license) for the full license text.


## Security disclosure

We take Canyan's security and our users trust very seriously.
If you believe you have found a security issue in Canyan, please responsibly
disclose by contacting us at [security@canyan.io](mailto:security@canyan.io).


## Connect with us

* Follow us on [Twitter](https://twitter.com/canyan_io). Please
  feel free to tweet us questions.
* Connect with us on [LinkedIN](https://www.linkedin.com/company/canyan/).
* Join us on [Slack](http://slack.canyan.io)
* Fork us on [Github](https://github.com/canyanio)
* Email us at [info@canyan.io](mailto:info@canyan.io)
