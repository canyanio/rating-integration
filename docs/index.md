# Canyan Rating

Canyan Rating is an open source real-time highly scalable rating system.

The rating system is a critical component in any business, especially when real-time features are a strict requirement to ensure business continuity and congruence of transactions. Any compromise to availability, integrity, and authentication regarding the rating system makes a huge impact on the services provided.

Canyan aims to address these challenges with a cloud-native scalable solution, easily deployable and easily usable. It has been designed to work atomically ensuring the system status is always consistent, reproducible and coherent. Asynchronous processing of no real-time, consolidation events, prioritization, and time-boxed tasks provide the basics to ensure lightning-fast transaction processing without compromises.

Ease of use is addressed with comprehensive documentation, examples and high-quality software (see the test coverage badge).


## Components

Canyan Rating is designed as a microservice architecture and comprises [several repositories](https://github.com/canyanio). Its components are stateless, highly scalable and easily deployable via containers on-premises or in the cloud. 

### Agent

[![Build Status](https://gitlab.com/canyan/rating-agent/badges/master/pipeline.svg)](https://gitlab.com/canyan/rating-agent/pipelines) [![codecov](https://codecov.io/gh/canyanio/rating-agent/branch/master/graph/badge.svg)](https://codecov.io/gh/canyanio/rating-agent) [![Docker pulls](https://img.shields.io/docker/pulls/canyan/rating-agent.svg?maxAge=3600)](https://hub.docker.com/repository/docker/canyan/rating-agent)

The Agent component is a bidirectional component that interfaces with external systems that needs to rate it's traffic and services. 
It is written in [Python](https://www.python.org/) programming language, documented and highly covered with tests (see badges above).

### API

[![Build Status](https://gitlab.com/canyan/rating-api/badges/master/pipeline.svg)](https://gitlab.com/canyan/rating-api/pipelines) [![codecov](https://codecov.io/gh/canyanio/rating-api/branch/master/graph/badge.svg)](https://codecov.io/gh/canyanio/rating-api) [![Docker pulls](https://img.shields.io/docker/pulls/canyan/rating-api.svg?maxAge=3600)](https://hub.docker.com/repository/docker/canyan/rating-api)

The API is the interface towards the database, it is scalable and used by the internal and external components.
It is written in [Python](https://www.python.org/) programming language, fully asynchronous and very fast. It is documented and highly covered with tests (see badges above).

### Engine

[![Build Status](https://gitlab.com/canyan/rating-engine/badges/master/pipeline.svg)](https://gitlab.com/canyan/rating-engine/pipelines) [![codecov](https://codecov.io/gh/canyanio/rating-engine/branch/master/graph/badge.svg)](https://codecov.io/gh/canyanio/rating-engine) [![Docker pulls](https://img.shields.io/docker/pulls/canyan/rating-engine.svg?maxAge=3600)](https://hub.docker.com/repository/docker/canyan/rating-engine)

The heavy lifting and real time calculation is done by the Rating Engine component which is stateless and highly scalable.
It is written in [Python](https://www.python.org/) programming language, documented and covered with tests (see badges above).

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
