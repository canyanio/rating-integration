# Begin Transaction
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 

## Request headers
```Content-Type	application/json```

## Request parameters
| Parameter | type | description |
|-|-|-|
|`beginTransaction.transaction_tag`| *str* | unique id of the transaction |
|`beginTransaction.account_tag` |	*str*	| account tag |
|`beginTransaction.destination_account_tag`	| *str*	| destination account tag (if exists) |
|`beginTransaction.source`	| *str*	| source |
|`beginTransaction.destination`	| *str*	| destination |
|`beginTransaction.timestamp_begin`	| *datetime*	| timestamp of the begin of the transaction |

## Response
| Field | type | description |
|-|-|-|
|`beginTransaction.ok` | *bool* | Has the transaction started correctly? |

## Example
### Request
```bash
$ curl "https://agent.canyan.io/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "mutation {
    beginTransaction(
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
    "beginTransaction": { 
      "ok": True 
    }
  }
}
```
