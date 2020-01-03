# End Transaction
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 

## Request headers
```Content-Type	application/json```

## Request parameters
| Parameter | type | description |
|-|-|-|
|`endTransaction.transaction_tag`| *str* | unique id of the transaction |
|`endTransaction.account_tag` |	*str*	| account tag |
|`endTransaction.destination_account_tag`	| *str*	| destination account tag (if exists) |
|`endTransaction.timestamp_end`	| *datetime*	| timestamp of the end of the transaction |

## Response
| Field | type | description |
|-|-|-|
|`endTransaction.ok` | *bool* | Has the transaction ended correctly? |

## Example
### Request
```bash
$ curl "https://agent.canyan.io/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "mutation {
    endTransaction(
        tenant: "default",
        transaction_tag: "100",
        account_tag: "1000",
        destination_account_tag: "1001"
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
    "endTransaction": { 
      "ok": True 
    }
  }
}
```
