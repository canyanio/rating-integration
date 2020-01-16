# Authorization
This endpoint performs pre-transaction authorization checks.

## Request headers
```Content-Type	application/json```

## Request parameters
| Parameter | type | description |
|-|-|-|
|`authorization.transaction_tag`| *str* | unique id of the transaction |
|`authorization.account_tag` |	*str*	| account tag |
|`authorization.destination_account_tag`	| *str*	| destination account tag (if exists) |
|`authorization.source`	| *str*	| source |
|`authorization.destination`	| *str*	| destination |
|`authorization.timestamp_auth`	| *datetime*	| timestamp of the authorization request |


## Response
| Field | type | description |
|-|-|-|
|`authorization.transaction_tag`	| *string* | Unique identifier of the transaction |
|`authorization.account_tag` | *string*	| The tag of the account performing the transaction |
|`authorization.destination_account_tag` | *string* | The destination account (if exists) |
|`authorization.authorized` | *bool* | Is the transaction authorized to be performed |
|`authorization.authorized_destination` | *bool*	| Is the destination authorized to receive the call |
|`authorization.unauthorized_account_tag` | *string*	| Account tag |
|`authorization.unauthorized_account_reason` | *string*	| If unauthorized account specify reason |
|`authorization.unauthorized_destination_reason` | *string*	| If unauthorized destination - specify reason |
|`authorization.max_available_units` | *int*	| Max available units of the account|
|`authorization.balance` | *int*	| Balance of the account|
|`authorization.carriers` | *string*	| Prioritized list of carriers to use |


## Example
### Request
```bash
curl "https://agent.canyan.io/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "mutation {
    authorization(
        tenant: "default",
        transaction_tag: "100",
        account_tag: "1000",
        destination_account_tag: "1001",
        source: "sip:10.0.0.1:5060",
        destination: "sip:10.0.0.2:5060"
    ) {
        authorized
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
    "authorization": { 
      "authorized": True 
    }
  }
}
```
