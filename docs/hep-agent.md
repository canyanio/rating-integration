# Canyan Rating HEP Agent

[![Build Status](https://gitlab.com/canyan/rating-agent-hep/badges/master/pipeline.svg)](https://gitlab.com/canyan/rating-agent-hep/pipelines) [![codecov](https://codecov.io/gh/canyanio/rating-agent-hep/branch/master/graph/badge.svg)](https://codecov.io/gh/canyanio/rating-agent-hep) [![Docker pulls](https://img.shields.io/docker/pulls/canyan/rating-agent-hep.svg?maxAge=3600)](https://hub.docker.com/repository/docker/canyan/rating-agent-hep)

The Agent repository is available [here](https://github.com/canyanio/rating-agent-hep).

This component uses the [HEP/EEP Encapsulation Protocol](https://github.com/sipcapture/hep)
for packet capture and mirroring of RTC solutions which allows for a transparent and unobtrusive rating solution. It supports both TCP and UDP communication protocols.

It is written in [Go](https://golang.org/) programming language, documented and highly covered with tests (see badges above).


## Usage examples

We cover different integration scenarios in this documentation. Please refer to the [Kamailio Integration tutorial](tutorials/kamailio-hep-integration.md) for an example on how to use Canyan Rating Engine with Kamailio via the HEP Agent, or the [OpenSIPS Integration tutorial](tutorials/opensips-hep-integration.md) for an example on how to use Canyan Rating Engine with OpenSIPS via the HEP Agent.
