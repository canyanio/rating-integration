# Inserting Demo Data in Canyan Rating

This tutorial will help you insert some basic data in order to start making requests and try 
Canyan Rating Engine with your system. 

## Prerequisites

The test environment should be set up and running successfully as described in 
[Running Canyan Rating](/running/) section.

We will assume the API is running on `localhost:8000`.

## Creating a Carrier

Let's start with the termination of your calls defining a carrier parameters with this request:
```bash
$ curl "http://localhost:8000/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "mutation {
  createCarrier(carrier_tag: \"carrier1\", host: \"localhost\", port: 5061, protocol: UDP, active: true) {
    carrier_tag
    host
    port
    protocol
    active
  }
}
"
}
EOF
```
The requests is self explainatory: it defines a carrier named `carrier1` which is listening to the port `5061` of `localhost` via `UDP` protocol.
You should recieve a response like this from the API:
```bash
HTTP/1.1 200 OK
Content-Type: application/json
{
  "data": {
    "createCarrier": {
      "carrier_tag": "carrier1",
      "host": "localhost",
      "port": 5061,
      "protocol": "UDP",
      "active": true
    }
  }
}
```

## Creating a Price List

We can now proceed creating a Price List witch we will associate rates in the next section of this tutorial:

```bash
$ curl "http://localhost:8000/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "mutation {
  createPricelist(pricelist_tag: \"pricelist1\", name: \"First pricelist\", currency: EUR) {
    pricelist_tag
    name
    currency
  }
}
"
}
EOF
```
Here again the request is very simple with a pricelist tag we will use to refer to this price list in the requests below and we will associate a name with this pricelist that can explain a little bit better this price list.
The API will respond like this:
```bash
HTTP/1.1 200 OK
Content-Type: application/json
{
  "data": {
    "createPricelist": {
      "pricelist_tag": "pricelist1",
      "name": "First pricelist",
      "currency": "EUR"
    }
  }
}
```

## Creating a Rate

So let's create the first rate of the newly created pricelist above:
```bash
$ curl "http://localhost:8000/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "mutation {
  createPricelistRate(
        pricelist_tag: \"pricelist1\",
        carrier_tag: \"carrier1\",
        prefix: \"39\",
        connect_fee: 0,
        rate: 20,
        rate_increment: 60,
        interval_start: 0,
        description: \"Italy\"
  ) {
    pricelist_tag
    carrier_tag
    prefix
    datetime_start
    datetime_end
    connect_fee
    rate
    rate_increment
    interval_start
    description
  }
}"
}
EOF
```
As you can observe we associated this rate to the `pricelist1`. The call will be routed to `carrier1` we defined above for this destination. The matching prefix is `39`, the Italian country code.
The pricelist is active right now and is valid indefinitely.
There is no connect fee, the rate is set to 20 per minute and the rate is applied from second 0 of the call.

The expected response is:
```bash
HTTP/1.1 200 OK
Content-Type: application/json
{
  "data": {
    "createPricelistRate": {
      "pricelist_tag": "pricelist1",
      "carrier_tag": "carrier1",
      "prefix": "39",
      "datetime_start": null,
      "datetime_end": null,
      "connect_fee": 0,
      "rate": 20,
      "rate_increment": 60,
      "interval_start": 0,
      "description": "Italy"
    }
  }
}
```

## Creating an Account

Now let's create an account that can use our rating engine:

```bash
$ curl "http://localhost:8000/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <your-token-here>" \
  --data @- <<EOF
{"query": "mutation {
  createAccount(
    account_tag: \"100\",
    type: PREPAID,
    balance: 100,
    max_concurrent_transactions: 2,
    name: \"My first account\",
    active: true,
    pricelist_tags: [\"pricelist1\"]
  ) {
    account_tag
    name
    type
    balance
    max_concurrent_transactions
    pricelist_tags
  }
}"
}
EOF
```
This will be a prepaid account which balance is set to 100, it can use 2 concurrent calls and the pricelist applied is `pricelist1`.

The response should look like this:
```bash
HTTP/1.1 200 OK
Content-Type: application/json
{
  "data": {
    "createAccount": {
      "account_tag": "100",
      "name": "My first account",
      "type": "POSTPAID",
      "balance": 1000,
      "max_concurrent_transactions": 10,
      "pricelist_tags": [
        "pricelist1"
      ]
    }
  }
}
```

Now we have a basic set of components that we can use in the next tutorials. 
