# Rollback Transaction
This method allows you to remove a transaction.

## Request headers
```Content-Type	application/json```

## Request parameters
| Parameter | type | description |
|-|-|-|
|`rollbackTransaction.transaction_tag`| *str* | unique id of the transaction |
|`rollbackTransaction.account_tag` |	*str*	| account tag (optional) |
|`rollbackTransaction.destination_account_tag`	| *str*	| destination account tag (optional) |

## Response
| Field | type | description |
|-|-|-|
|`rollbackTransaction.ok` | *bool* | Has the transaction been rolled back correctly? |

## Example
### Request
```bash
curl "https://agent.canyan.io/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "mutation {
    rollbackTransaction(
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
    "rollbackTransaction": { 
      "ok": True 
    }
  }
}
```
