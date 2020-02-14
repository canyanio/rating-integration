# Integration with Kamailio

[Kamailio](https://www.kamailio.org/) is an Open Source SIP Server released under GPL, able to handle thousands of call setups per second. Kamailio can be used to build large platforms for VoIP and realtime communications – presence, WebRTC, Instant messaging and other applications.  Moreover, it can be easily used for scaling up SIP-to-PSTN gateways, PBX systems or media servers like Asterisk™, FreeSWITCH™ or SEMS.


## Prerequisites

The test environment should be set up and running successfully as described in [Running Canyan Rating](/running.md) section.
You should have a basic set of data populated in your Canyan Rating instance as described in the [Inserting Data Tutorial](/tutorials/inserting-data/).
The following commands and requests relay on the same data inserted in the above tutorial. If you populated different data you should change the commands in this tutorial accordingly.

After cloning the [integration repository](https://github.com/canyanio/rating-integration) the [Makefile](https://github.com/canyanio/rating-integration/blob/master/Makefile) provides us with two shortcut commands:
`make start` and `make stop`.

## Scope

Integrating the authorization, begin and start transaction methods of the Rating Engine in a Kamailio instance.
Kamailio needs to perform an authorization for every outgoing and incoming call, getting all the information needed to perform or not the calls. Also the begin and end of a call needs to be signalized to the Rating Engine.

The Rating Agent is listening for http requests with REST and GraphQL APIs. In Kamailio we will use the [HTTP_ASYNC_CLIENT Module](https://www.kamailio.org/docs/modules/stable/modules/http_async_client.html) to avoid binding Kamailio workers with synchronous http calls.


## Kamailio configuration

The integration repository contains an [example configuration file](https://github.com/canyanio/rating-integration/blob/master/conf/kamailio/rating.cfg) for the integration with Canyan's Rating Engine.

>**Note:** The Kamailio configuration file is simple and basic for the purpose 
> of this tutorial and should not be used in production.


### Authorization

Let's start with the authorization method of the Rating Engine.
In the [kamailio.cfg](https://github.com/canyanio/rating-integration/blob/master/conf/kamailio/kamailio.cfg) we can notice this piece of code:
```
if (is_method("INVITE") && !has_totag()) {
  $dlg_var(account_tag) = $fU;

  route(RATING_AUTHORIZATION);
}
```
The route `RATING_AUTHORIZATION` is run for every new `INVITE` method that does not have a `to` tag.

`RATING_AUTHORIZATION` prepares the json to be sent to the Rating Agent populating the following variables:

* transaction_tag (`$ci`)
* account_tag (`$dlg_var(account_tag)`)
* source (`$fu`)
* destination (`$tu`)

The route `RATING_AUTHORIZATION_RESPONSE` is the most complex of the Canyan Rating Engine Kamailio integration routes.
It handles the response from the Agent to the `authorization` endpoint request.
Let's break it down and see what it does.

The first check is performed on the response from the Agent module. It checks if the http response is 200 then it checks if the response contains the expected fields.

Then the max available units are set to a variable that will be used if the call is authorized to set the dialog timeout with `dlg_set_timeout`.

The check of the unauthorized reasons is then performed to send the correct reply to the SIP client.

It there are no errors the prioritized carriers list is gathered from the authorization response and the list is parsed with the route `RATING_AUTHORIZATION_PARSE_CARRIERS`.

At the end of the route the `SIPOUT` route is called.


### Begin Transaction

The route `RATING_BEGIN_TRANSACTION` is called with the event route [dialog:start](https://kamailio.org/docs/modules/stable/modules/dialog.html#idm1446).

The route prepares the following variables for the Rating Agent http async call:

* transaction_tag (`$ci`)
* account_tag (`$dlg_var(account_tag)`)
* source (`$fu`)
* destination (`$tu`)

Then the route `RATING_BEGIN_TRANSACTION_RESPONSE` that handles the response from the Agent is doing some simple checks like `http_ok` and if the http response code is 200. After that the check of the content of the response is performed and it consists in checking if the variable `ok` is true.

If some of the checks are not good the route sends a 500 reply to che client with a message that the Rating is not available. The route also prints an xlog with alert log level and the http error.


### End Transaction

The route `RATING_END_TRANSACTION` sets the following variables to be sent to the Agent via http async call:

* transaction_tag (`$ci`)
* account_tag (`$dlg_var(account_tag)`)
* source (`$var(query)`)
* destination (`$var(query)`)

As for the Begin Transaction there is a simple `RATING_END_TRANSACTION_RESPONSE` route that handles the response and checks the correct http response and the value of the `ok` boolean variable inside the response body.
It sends SIP error replies and logs with alert log level the issue.


## Testing

The integration repository contains also [tests](https://github.com/canyanio/rating-integration/tree/master/tests) that can be run with a simple `make test` after the `make start` command. Plese refer to those tests to see how this implementation inside kamailio is tested with Canyan Rating Engine.
The tests are run with the open source tool [canyan-tester](https://github.com/wazo-platform/canyan-tester) so refer to the documentation of that tool for better understanding of the test process.
