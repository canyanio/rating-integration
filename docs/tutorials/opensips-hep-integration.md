# Integration with OpenSIPS via HEP Agent

[OpenSIPS](https://www.opensips.org/) is an Open Source [SIP](https://www.ietf.org/rfc/rfc3261.txt) proxy/server for voice, video, IM, presence and any other SIP extensions.

OpenSIPS is a multi-functional, multi-purpose signaling SIP server used by carriers, telecoms or ITSPs for solutions like Class4/5 Residential Platforms, Trunking / Wholesale, Enterprise / Virtual PBX Solutions, Session Border Controllers, Application Servers, Front-End Load Balancers, IMS Platforms, Call Centers, and many others - see the full Set of Features.

OpenSIPS is recommended for any kind of SIP scenario / service by:
* the **high throughput** - tens of thousands of CPS, millions of ‏simultaneous calls (see official tests)
* the **flexibility of routing and integration** - routing script for implementing custom routing logics, several interfacing APIs (see the Manual)
* the **effective application building** - more than 120 modules to provide features, for SIP handling, for backend operations, for integration, for routing logics (see List of Modules)


## Prerequisites

The [Rating Agent HEP repository](https://github.com/canyanio/rating-agent-hep) contains everything we need for understanding the usage of Canyan Rating Engine with OpenSIPS in a more transparent and unobtrusive way.

The [Makefile](https://github.com/canyanio/rating-agent-hep/blob/master/Makefile) provides us with two shortcut commands which are usual for all of our solutions:
`make docker-start` and `make docker-stop`.

Also there is a `docker-start-opensips` which starts the OpenSIPS instance along with the Canyan Rating and a `make test-opensips` command that runs the different tests and also checking the correct data storage in Canyan Rating after the test calls.


## Scope

In this integration example there is no authorization for the outgoing and incoming calls to the OpenSIPS box. OpenSIPS is using the [Tracer module](https://opensips.org/html/docs/modules/3.0.x/tracer.html) duplicating the incoming/outgoing SIP messages to the Rating Engine HEP using HEP, the [Homer encapsulation protocol](https://github.com/sipcapture/HEP).

This example uses the TCP communication protocol. For an example of usage with the UDP protocol take a look at the example [integration with Kamailio](kamailio-hep-integration.md).


## Opensips configuration

The HEP Agent repository contains an [example configuration file](https://github.com/canyanio/rating-agent-hep/blob/master/tests/opensips/opensips.cfg) for the integration with Canyan's Rating Agent HEP.

>**Note:** The Opensips configuration file is simple and basic for the purpose 
> of this tutorial and should not be used in production.

Let's take a look in more detail on the different sections of the `opensips.cfg` file provided:

### Includes and modparams

First of all we need the [Proto_HEP module](https://opensips.org/html/docs/modules/3.0.x/proto_hep.html) in order to be able to use the HEP protocol in OpenSIPS:
```
loadmodule "proto_hep.so"
listen = hep_tcp:0.0.0.0:6061
modparam("proto_hep", "hep_capture_id", 1)
modparam("proto_hep", "hep_id", "[hid] rating-agent-hep:9060; transport=tcp; version=3")
```

`rating-agent-hep` is the hostname of the container in the [docker-compose.yaml](https://github.com/canyanio/rating-agent-hep/blob/master/docker-compose.yaml) file.


The [Tracer module](https://opensips.org/html/docs/modules/3.0.x/tracer.html) is configured like this:
```
loadmodule "tracer.so"
modparam("tracer", "trace_on", 1)
modparam("tracer", "trace_id", "[tid]uri=hep:hid")
```

Please note the `hep:hid` where the `hid` is the tag of our `hep_id` defined in the `proto_hep` modparam above.


### Using `trace` function

Now in our main `route` there is a `trace` function:
```
route {

  $var(trace_id) = "tid";
  trace($var(trace_id), "m", "sip");
  ...
}
```

In the [Tracer module](https://opensips.org/html/docs/modules/3.0.x/tracer.html) we can find the definition of the `trace` command:
```trace(trace_id, [scope], [type], [trace_attrs])```

Where `trace_id` is the name of the trace_id specifying where to do the tracing. In our case `tid` defined in the tracer modparam above.

`Scope` defines what do you want to trace: dialog, transaction or only the message. In our case `m` specifies that we want to trace the messages.

`Type` list of types of messages to be traced by this function, in our case the `sip` messages tracing is enabled.

As you can see it's quite a simple integration.


## Testing

In the [tests](https://github.com/canyanio/rating-agent-hep/blob/master/tests/) directory of the Rating Agent HEP we can find our usual scenarios files (as seen in the integration repository) and the tests can be run using `make docker-test-opensips` after the `make docker-start-opensips` command.

The tests are run with [canyan-tester](https://github.com/canyanio/canyan-tester), our open source testing tool. For usage information and better understanding of the testing process with canyan-tester please refer to the tester [README](https://github.com/canyanio/canyan-tester/blob/master/README.md).

Now, let's take a look at the [test_opensips_call.yaml](https://github.com/canyanio/rating-agent-hep/blob/master/tests/scenarios/test_opensips_call.yaml) file. We can immediately spot the three main sections:
* setup
* workers
* check

The `setup` section runs API calls to create the needed accounts, price lists and rates to perform the call

Then the a [sipp](http://sipp.sourceforge.net/) worker in the `workers` section use the [test_opensips_call.xml](https://github.com/canyanio/rating-agent-hep/blob/master/tests/scenarios/test_opensips_call.xml) scenario file to make a call towards our just configured kamailio box.

In the end the `check` section of our `test_opensips_call.yaml` performs an API call and expects the `transaction` of the `sipp` call to be registered in the Canyan Rating system.


## Conclusion

As seen it's quite easy to integrate the Canyan Rating Agent HEP with OpenSIPS in an unobtrusive and transparent way.

For more details on how to run Canyan Rating you should take a look at the [Running Canyan Rating](/running.md) section of this documentation.

The above tests insert testing data on the fly but you should take a look at the [Inserting Data Tutorial](/tutorials/inserting-data/) to be able to insert your own data in Canyan Rating.
