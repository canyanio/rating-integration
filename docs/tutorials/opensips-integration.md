# Integration with OpenSIPS

[OpenSIPS](https://www.opensips.org/) is an Open Source [SIP](https://www.ietf.org/rfc/rfc3261.txt) proxy/server for voice, video, IM, presence and any other SIP extensions.

OpenSIPS is a multi-functional, multi-purpose signaling SIP server used by carriers, telecoms or ITSPs for solutions like Class4/5 Residential Platforms, Trunking / Wholesale, Enterprise / Virtual PBX Solutions, Session Border Controllers, Application Servers, Front-End Load Balancers, IMS Platforms, Call Centers, and many others - see the full Set of Features.

OpenSIPS is recommended for any kind of SIP scenario / service by:
* the **high throughput** - tens of thousands of CPS, millions of ‏simultaneous calls (see official tests)
* the **flexibility of routing and integration** - routing script for implementing custom routing logics, several interfacing APIs (see the Manual)
* the **effective application building** - more than 120 modules to provide features, for SIP handling, for backend operations, for integration, for routing logics (see List of Modules)


## Prerequisites

The [integration repository](https://github.com/canyanio/rating-integration) contains everything we need for understanding the usage of Canyan Rating Engine with OpenSIPS.
The [Makefile](https://github.com/canyanio/rating-integration/blob/master/Makefile) provides us with two shortcut commands:
`make docker-start` and `make docker-stop`.

Also there is a `make test-opensips` command that we will look at in a while to understand what is happening behind the scenes.

## Scope

Integrating the authorization, begin and start transaction methods of the Rating Engine in an OpenSIPS instance.
OpenSIPS needs to perform an authorization for every outgoing and incoming call, getting all the information needed to perform or not the calls. Also the begin and end of a call needs to be signalized to the Rating Engine.

The Rating Agent is listening for http requests with REST and GraphQL APIs. In OpenSIPS we will use the [REST Module](https://opensips.org/docs/modules/3.0.x/rest_client.html) in combination with [Asynchronous Statements](https://www.opensips.org/Documentation/Script-Async-3-0) to avoid binding OpenSIPS workers with synchronous http calls.


## OpenSIPS configuration

The integration repository contains an [example configuration file](https://github.com/canyanio/rating-integration/blob/master/conf/opensips/rating.cfg) for the integration with Canyan's Rating Engine.

>**Note:** The OpenSIPS configuration file is simple and basic for the purpose 
> of this tutorial and should not be used in production.


### Authorization

Let's start with the authorization method of the Rating Engine.
In the [opensips.cfg](https://github.com/canyanio/rating-integration/blob/master/conf/opensips/opensips.cfg) we can notice this piece of code:
```
if (is_method("INVITE") && !has_totag()) {
  route(rating_authorization);
}
```
The route `rating_authorization` is run for every new `INVITE` method that does not have a `to` tag.

`rating_authorization` prepares the json to be sent to the Rating Agent populating the following variables:

* transaction_tag (`$ci`)
* account_tag (`$fU`)
* source (`$fu`)
* destination (`$tu`)

The route `rating_authorization_response` is the most complex of the Canyan Rating Engine OpenSIPS integration routes.
It handles the response from the Agent to the `authorization` endpoint request.
Let's break it down and see what it does.

The first check is performed on the response from the Agent module. It checks if the http response is 200 then it checks if the response contains the expected fields.

Then the max available units are set to a variable that will be used if the call is authorized to set the dialog timeout with `DLG_timeout`.

The check of the unauthorized reasons is then performed to send the correct reply to the SIP client.

It there are no errors the prioritized carriers list is gathered from the authorization response and the top priority carrier is used in the `$du` variable.

At the end of the route the `relay` route is called.


### Begin Transaction

The route `rating_begin_transaction` is called within the `if` statement of the [event route](https://opensips.org/html/docs/modules/3.0.x/event_route.html) for the [E_DLG_STATE_CHANGED](https://opensips.org/docs/modules/3.0.x/dialog.html#event_E_DLG_STATE_CHANGED) event. The same event route is used for the end transaction. If the `$param(new_state)` is set to `4` it means that the dialog has started and that's where we trigger the route `rating_begin_transaction`.

The route prepares the following variables for the Rating Agent http async call:

* transaction_tag (`$avp(ci)`)
* timestamp (`$Ts`)

Please note that the `$avp(ci)` is populated in the event route with the `$param(callid)` from the event.

There is no need for other fields because the Rating Engine uses the `transaction_tag` to lookup for the data sent by the `rating_authorization` route.

Then the route `rating_begin_transaction_response` that handles the response from the Agent is doing some simple checks with `rcode`. The code then does the check of the content of the response which consists in checking if the variable `ok` is `true`.

If some of the checks are not good the route sends a `500 reply` to che client with a message that the Rating is not available. The route also prints an `xlog` with alert log level and the http error.


### End Transaction

As for the `begin transaction`, the `end transaction` route is called with the `event route` on the dialog state change. In this case the new state is `5`.

The route `rating_end_transaction` sets the following variables to be sent to the Agent via http async call:

* transaction_tag (`$avp(ci)`)
* timestamp (`$Ts`)

Please note that the `$avp(ci)` is populated in the event route with the `$param(callid)` from the event.
Unfortunately we now loose the dialog variables because there is no more dialog but all we need is the `transaction_tag` because the Rating Engine is capable of restoring the needed information gathered from previous requests.

As for the Begin Transaction there is a simple `rating_end_transaction_response` route that handles the response from the Agent and checks the correct http response code and the value of the `ok` boolean variable inside the response body.
It sends SIP error replies and logs with alert log level if there is any issue.


## Testing

The integration repository contains also a [tests](https://github.com/canyanio/rating-integration/tree/master/tests) directory that can be run with a simple `make test-opensips` after the `make docker-start` command. Please refer to those tests to see how the implementation inside OpenSIPS is tested with Canyan Rating Engine.

The tests are run with the open source tool [canyan-tester](https://github.com/canyanio/canyan-tester) so refer to the documentation of that tool for better understanding the test process.
