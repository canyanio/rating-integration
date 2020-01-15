# Authorizations

The scope of this tutorial is to make your first authorizations with Canyan Rating and how to use this functionality with your own system.


## Prerequisites

The test environment should be set up and running successfully as described in [Running Canyan Rating](/running.md) section.
You should have a basic set of data populated in your Canyan Rating instance as described in the [Inserting Data Tutorial](/tutorials/inserting-data/).
The following commands and requests relay on the same data inserted in the above tutorial. If you populated different data you should change the commands in this tutorial accordingly.

It is assumed that the API is running on `localhost:8000` and the Agent on `localhost:8080`.


## Request

We will now send a request to the Agent component asking for authorization regarding an outbound 
call performed by our account `100`.

```bash
curl "http://localhost:8080/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "mutation {
    authorization(
        transaction_tag: \"transaction1\",
        account_tag: \"100\",
        source: \"sip:10.0.0.1:5060\",
        destination: \"39040123123\"
    ) {
        transaction_tag
        account_tag
        authorized
        max_available_units
        balance
        carriers
    }
  }"
}
EOF
```

We will use an unique tag for the transaction, will specify the account 
performing the call and will also specify the source of the call and the 
destination the account is trying to reach out to.


## Response

The response should be like this:
```bash
HTTP/1.1 200 OK
Content-Type: application/json
{
  "data": {
    "authorization": { 
      "transaction_tag": "transaction1",
      "account_tag": "100",
      "authorized": True,
      "max_available_units": 300
      "balance": 100
      "carriers": "localhost:5061"
    }
  }
}
```

The Agent component is responding that for our transaction `transaction1` 
the account `100` calling an Italian prefix is allowed to proceed and that 
the max available units for that call are `300` seconds. The actual balance 
the account has is `100` and the carrier it is supposed to use is `carrier1`
available on `localhost:5061`.
