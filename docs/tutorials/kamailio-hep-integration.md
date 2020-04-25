# Integration with Kamailio via HEP Agent

[Kamailio](https://www.kamailio.org/) is an Open Source SIP Server released under GPL, able to handle thousands of call setups per second. Kamailio can be used to build large platforms for VoIP and realtime communications – presence, WebRTC, Instant messaging and other applications.  Moreover, it can be easily used for scaling up SIP-to-PSTN gateways, PBX systems or media servers like Asterisk™, FreeSWITCH™ or SEMS.


## Prerequisites

The [Rating Agent HEP repository](https://github.com/canyanio/rating-agent-hep) contains everything we need for understanding the usage of Canyan Rating Engine with Kamailio in a more transparent and unobtrusive way.

The [Makefile](https://github.com/canyanio/rating-agent-hep/blob/master/Makefile) provides us with two shortcut commands which are usual for all of our solutions:
`make docker-start` and `make docker-stop`.

Also there is a `docker-start-kamailio` which starts the kamailio instance along with the Canyan Rating and a `make test-kamailio` command that runs the different tests and also checking the correct data storage in Canyan Rating after the test calls.


## Scope

In this integration example there is no authorization for the outgoing and incoming calls to the Kamailio box. Kamailio is using the [SipTrace module](https://www.kamailio.org/docs/modules/devel/modules/siptrace.html) duplicating the incoming/outgoing SIP messages to the Rating Engine HEP sing HEP, the [Homer encapsulation protocol](https://github.com/sipcapture/HEP).

This example uses the UDP communication protocol. For an example of usage with the TCP protocol take a look at the example [integration with OpenSIPS](tutorials/opensips-hep-integration.md).


## Kamailio configuration

The HEP Agent repository contains an [example configuration file](https://github.com/canyanio/rating-agent-hep/blob/master/tests/kamailio/kamailio.cfg) for the integration with Canyan's Rating Agent HEP.

>**Note:** The Kamailio configuration file is simple and basic for the purpose 
> of this tutorial and should not be used in production.

Let's take a look in more detail on the different sections of the `kamailio.cfg` file provided:

### Includes and modparams

First of all the [kamailio-local.cfg](https://github.com/canyanio/rating-agent-hep/blob/master/tests/kamailio/kamailio-local.cfg) file defines the following:
```
#!define WITH_SIPTRACE 1
#!define HEP_CAPTURE_ID 1
#!define RATING_AGENT_HEP "sip:rating-agent-hep:9060"
```
`rating-agent-hep` is the hostname of the container in the [docker-compose.yaml](https://github.com/canyanio/rating-agent-hep/blob/master/docker-compose.yaml) file.

If we now take a look at the [kamailio.cfg](https://github.com/canyanio/rating-agent-hep/blob/master/tests/kamailio/kamailio.cfg) file we can easily spot the configuration needed for using the HEP Agent:

```
#!ifdef WITH_SIPTRACE
loadmodule "siptrace.so"
#!endif
...
# ----- siptrace params -----
#!ifdef WITH_SIPTRACE
modparam("siptrace", "trace_on", 1)
modparam("siptrace", "trace_to_database", 0)
modparam("siptrace", "hep_mode_on", 1)
modparam("siptrace", "hep_version", 3)
modparam("siptrace", "hep_capture_id", HEP_CAPTURE_ID)
#!endif
...
```

### Using `sip_trace` function

Now in our main route (`request_route`) there is a call to a route called `SIPTRACE` here:
```
request_route {

#!ifdef WITH_SIPTRACE
    # enable siptrace
    route(SIPTRACE);
#!endif
    ...
}
```

And finally we can see the `sip_trace` function call in this block:
```
#!ifdef WITH_SIPTRACE
route[SIPTRACE] {
    # enable sip tracing
    sip_trace(RATING_AGENT_HEP, "$ci");
}
#!endif
```

As you can see it's quite a simple integration and we could just add this
```
sip_trace("sip:rating-agent-hep:9060", "$ci");
```
to our `request_route`. The call ID (`$ci`) is used as a `correlation_id`.


## Testing

In the [tests](https://github.com/canyanio/rating-agent-hep/blob/master/tests/) directory of the Rating Agent HEP we can find our usual scenarios files (as seen in the integration repository) and the tests can be run using `make docker-test-kamailio` after the `make docker-start-kamailio` command.

The tests are run with [canyan-tester](https://github.com/canyanio/canyan-tester), our open source testing tool. For usage information and better understanding of the testing process with canyan-tester please refer to the tester [README](https://github.com/canyanio/canyan-tester/blob/master/README.md).

Now, let's take a look at the [test_kamailio_call.yaml](https://github.com/canyanio/rating-agent-hep/blob/master/tests/scenarios/test_kamailio_call.yaml) file. We can immediately spot the three main sections:
* setup
* workers
* check

The `setup` section runs API calls to create the needed accounts, price lists and rates to perform the call

Then the a [sipp](http://sipp.sourceforge.net/) worker in the `workers` section use the [test_kamailio_call.xml](https://github.com/canyanio/rating-agent-hep/blob/master/tests/scenarios/test_kamailio_call.xml) scenario file to make a call towards our just configured kamailio box.

In the end the `check` section of our `test_kamailio_call.yaml` performs an API call and expects the `transaction` of the `sipp` call to be registered in the Canyan Rating system.


## Conclusion

As seen it's quite easy to integrate the Canyan Rating Agent HEP with Kamailio in an unobtrusive and transparent way.

For more details on how to run Canyan Rating you should take a look at the [Running Canyan Rating](/running.md) section of this documentation.

The above tests insert testing data on the fly but you should take a look at the [Inserting Data Tutorial](/tutorials/inserting-data/) to be able to insert your own data in Canyan Rating.
