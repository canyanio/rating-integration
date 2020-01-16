# Record Transaction
In this method we can begin and end a transaction with one call.

## Request headers
```Content-Type	application/json```

## Request parameters
| Parameter | type | description |
|-|-|-|
|`recordTransaction.transaction_tag`| *str* | unique id of the transaction |
|`recordTransaction.account_tag` |	*str*	| account tag |
|`recordTransaction.destination_account_tag`	| *str*	| destination account tag (if exists) |
|`recordTransaction.source`	| *str*	| source |
|`recordTransaction.destination`	| *str*	| destination |
|`authorization.timestamp_auth`	| *datetime*	| timestamp of the authorization request |
|`recordTransaction.timestamp_begin`	| *datetime*	| timestamp of the begin of the transaction |
|`recordTransaction.timestamp_end`	| *datetime*	| timestamp of the end of the transaction |
|`recordTransaction.failed` | *bool* | Has the transaction failed? |
|`recordTransaction.failed_reason`	| *str*	| If the transaction failed what is the reason? (optional) |

## Response
| Field | type | description |
|-|-|-|
|`recordTransaction.ok` | *bool* | Has the transaction been recorded correctly? |

## Example
### Request
```bash
curl "https://agent.canyan.io/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "mutation {
    recordTransaction(
        tenant: "default",
        transaction_tag: "100",
        account_tag: "1000",
        destination_account_tag: "1001",
        source: "sip:10.0.0.1:5060",
        destination: "sip:10.0.0.2:5060"
    ) {
        ok
    }
  }"
}
EOF
```

### Response
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
