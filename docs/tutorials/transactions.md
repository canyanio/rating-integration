# Transactions

The scope of this tutorial is to make your first transactions and have an overview 
of the capabilities of Canyan Rating and how to use its functionalities with 
your system.


## Prerequisites

The test environment should be set up and running successfully as described 
in [Running Canyan Rating](/running.md) section.
You should have a basic set of data populated in your Canyan Rating instance as 
described in the [Inserting Data Tutorial](/tutorials/inserting-data/).
The following commands and requests relay on the same data inserted in the above 
tutorial. If you populated different data you should change the commands in 
this tutorial accordingly.

It is assumed that the API is running on `localhost:8000` and the Agent 
on `localhost:8080`.


## Begin Transaction

Let's start opening a new transaction for a call towards Italy performed 
by the account `100`:
```bash
$ curl "http://localhost:8080/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "mutation {
    beginTransaction(
        transaction_tag: \"transaction1\",
        account_tag: \"100\",
        source: \"sip:10.0.0.1:5060\",
        destination: \"39040123123\"
    ) {
        ok
    }
  }"
}
EOF
```

The response should give us a confirmation like this:
```bash
HTTP/1.1 200 OK
Content-Type: application/json
{
  "data": {
    "beginTransaction": { 
      "ok": True 
    }
  }
}
```

Now if we request the API for the account's `100` running transactions we 
should see our `transaction1` in the list:

```bash
$ curl "http://localhost:8000/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "{
  allAccounts(filter: { account_tag:\"100\" }) {
    account_tag
    name
    type
    balance
    pricelist_tags
    running_transactions {
      transaction_tag
      source
      destination
      carrier_ip
      in_progress
      inbound
      timestamp_begin
      timestamp_end
    }
  }
}"
}
EOF
```
Response:
```bash
HTTP/1.1 200 OK
Content-Type: application/json
{
  "data": {
    "allAccounts": [
      {
        "account_tag": "100",
        "name": "My first account",
        "type": "PREPAID",
        "balance": 100,
        "pricelist_tags": [
          "pricelist2"
        ],
        "running_transactions": [
          {
            "transaction_tag": "transaction1",
            "source": "sip:10.0.0.1:5060",
            "destination": "39040123123",
            "carrier_ip": "localhost:5061",
            "destination_rate": 20,
            "in_progress": true,
            "inbound": false,
            "timestamp_begin": "2019-08-15T21:26:17Z",
            "timestamp_end": ""
          }
        ]
      }
    ]
  }
}
```

`transaction1` is there!


## End Transaction

Using the `beginTransaction` method, once the user ended the call, we need to 
signal it to the Rating Engine.
We use the `endTransaction` method like this:

```bash
$ curl "http://localhost:8080/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "mutation {
    endTransaction(
        transaction_tag: \"transaction1\",
        account_tag: \"100\"
    ) {
        ok
    }
  }"
}
EOF
```

The response is confirming the end of the open transaction.
```bash
HTTP/1.1 200 OK
Content-Type: application/json
{
  "data": {
    "endTransaction": { 
      "ok": True 
    }
  },
  "errors": null
}
```

If we now redo the query on the account we can notice two different scenarios.

If the transaction is not processed it will still be in the running transactions 
with a timestamp end set and the `in_progress` field set to false and the balance 
still intact. Every calculation of the current user balance takes in consideration 
also the running transactions.

```bash
HTTP/1.1 200 OK
Content-Type: application/json
{
  "data": {
    "allAccounts": [
      {
        "account_tag": "100",
        "name": "My first account",
        "type": "PREPAID",
        "balance": 100,
        "pricelist_tags": [
          "pricelist2"
        ],
        "running_transactions": [
          {
            "transaction_tag": "transaction1",
            "source": "sip:10.0.0.1:5060",
            "destination": "39040123123",
            "carrier_ip": "localhost:5061",
            "destination_rate": 20,
            "in_progress": true,
            "inbound": false,
            "timestamp_begin": "2019-08-15T21:26:17Z",
            "timestamp_end": "2019-08-15T21:46:17Z"
          }
        ]
      }
    ]
  }
}
```

The second scenario is that the transaction has been processed, there is no more 
a running transaction in the account info and the balance of the account has 
been diminished.
```bash
HTTP/1.1 200 OK
Content-Type: application/json
{
  "data": {
    "allAccounts": [
      {
        "account_tag": "100",
        "name": "My first account",
        "type": "PREPAID",
        "balance": 80,
        "pricelist_tags": [
          "pricelist2"
        ],
        "running_transactions": []
      }
    ]
  }
}
```

In this case, the transaction has been saved and it is listed with the following 
requests to the API:

```bash
$ curl "http://localhost:8000/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "{Transaction(
    transaction_tag: \"transaction1\", 
    account_tag: \"100\"
  ) {
    id
    transaction_tag
    account_tag
    source
    source_ip
    destination
    destination_rate {
      pricelist_tag
      carrier_tag
      prefix
      connect_fee
      rate
      rate_increment
      interval_start
    }
    carrier_ip
    authorized
    timestamp_auth
    timestamp_begin
    timestamp_end
    inbound
    failed
    duration
    fee
  }
}"
}
EOF
```


## Record Transaction

If you need to write the transaction directly and avoid making the two requests 
`startTransaction` and `endTransaction` you can use the request `recordTransaction`:

```bash
$ curl "http://localhost:8080/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "mutation {
    recordTransaction(
        transaction_tag: \"transaction2\",
        account_tag: \"100\",
        source: \"sip:10.0.0.1:5060\",
        destination: \"39040123123\",
        timestamp_auth: \"2019-08-15T21:26:15Z\",
        timestamp_begin: \"2019-08-15T21:26:17Z\",
        timestamp_end: \"2019-08-15T21:26:55Z\"
    ) {
        ok
    }
  }"
}
EOF
```

The response should give us a confirmation like this:
```bash
HTTP/1.1 200 OK
Content-Type: application/json
{
  "data": {
    "recordTransaction": { 
      "ok": True 
    }
  }
}
```

The transaction is now visible with the request:
```bash
$ curl "http://localhost:8000/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "{Transaction(
    transaction_tag: \"transaction2\", 
    account_tag: \"100\"
  ) {
    id
    transaction_tag
    account_tag
    source
    source_ip
    destination
    destination_rate {
      pricelist_tag
      carrier_tag
      prefix
      connect_fee
      rate
      rate_increment
      interval_start
    }
    carrier_ip
    authorized
    timestamp_auth
    timestamp_begin
    timestamp_end
    inbound
    failed
    duration
    fee
  }
}"
}
EOF
```

```bash
HTTP/1.1 200 OK
Content-Type: application/json
{
  "data": {
    "Transaction": {
      "id": "0fa4a1b7-cc13-47a7-a4ae-2174e548fb19",
      "transaction_tag": "transaction2",
      "account_tag": "100",
      "source": "sip:10.0.0.1:5060",
      "destination": "39040123123",
      "destination_rate": {
        "pricelist_tag": "pricelist1",
        "carrier_tag": "carrier1",
        "prefix": "39",
        "connect_fee": 0,
        "rate": 20,
        "rate_increment": 60,
        "interval_start": 0
      },
      "carrier_ip": "localhost:5061",
      "authorized": null,
      "timestamp_auth": "2019-08-15T21:26:15Z",
      "timestamp_begin": "2019-08-15T21:26:17Z",
      "timestamp_end": "2020-01-15T14:26:55",
      "inbound": false,
      "failed": false,
      "duration": 38,
      "fee": 20
    }
  },
  "errors": null
}
```

## Rollback Transaction

This method allows the rollback of a particular transaction.

```bash
$ curl "http://localhost:8080/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "mutation {
    rollbackTransaction(
        transaction_tag: \"transaction2\",
        account_tag: \"100\"
    ) {
        ok
    }
  }"
}
EOF
```

The response should give us a confirmation like this:
```bash
HTTP/1.1 200 OK
Content-Type: application/json
{
  "data": {
    "rollbackTransaction": { 
      "ok": True 
    }
  }
}
```

And if we recheck the transaction via our usual request to the API:
```bash
$ curl "http://localhost:8000/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "{Transaction(
    transaction_tag: \"transaction2\", 
    account_tag: \"100\"
  ) {
    id
    transaction_tag
    account_tag
    source
    source_ip
    destination
    destination_rate {
      pricelist_tag
      carrier_tag
      prefix
      connect_fee
      rate
      rate_increment
      interval_start
    }
    carrier_ip
    authorized
    timestamp_auth
    timestamp_begin
    timestamp_end
    inbound
    failed
    duration
    fee
  }
}"
}
EOF
```

We will get this response:
```bash
HTTP/1.1 200 OK
Content-Type: application/json
{
  "data": {
    "Transaction": null
  },
  "errors": null
}
```

The transaction has been deleted via the Agent.
