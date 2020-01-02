# Account
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 

## Get all Accounts
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 

### Request headers
```Content-Type	application/json```

### Request parameters
| Parameter | type | description |
|-|-|-|
|`_allAccountsMeta.page`| *int* | page number, starting from zero |
|`_allAccountsMeta.perPage` |	*int*	| number of items returned per page |
|`_allAccountsMeta.sortField`	| *str*	| field used to sort the returned items, defaults to *id* |
|`_allAccountsMeta.sortOrder`	| *str*	| asc or desc, defaults to *asc* |

### Response
| Field | type | description |
|-|-|-|
|`allAccounts.id`	| *objectid* | Unique identifyer of the account |
|`allAccounts.account_tag` | *string*	| Identifyer of the account |
|`allAccounts.type` | *AccountType* | The type of the account (PREPAID / POSTPAID) |
|`allAccounts.balance` | *BigInt* | The balance of the account |
|`allAccounts.active` | *boolean*	| Is the account active? Default to true |
|`allAccounts.max_pending_transactions` | *int*	| The maximum number of active calls the account can make and recieve (outbound and inbound) |
|`allAccounts.name` | *string*	| Descriptive name of the account |
|`allAccounts.notification_email` | *string*	| The email the alerts should be sent to |
|`allAccounts.notification_mobile` | *string*	| The mobile phone an SMS alert should be sent to |
|`allAccounts.carrier_tags` | *array*	| List of preferred carriers for this account (prepended to the LCR for example) |
|`allAccounts.carrier_tags_override` | *array*	| List of carriers to force (other LCR carriers for example are ignored) |
|`allAccounts.customer_tag` | *string*	| A customer id this account is associated with |
|`allAccounts.linked_accounts` | *array*	| A list of parent accounts |
|`allAccounts.pricelist_tags` | *array*	| A list of pricelists to apply to this account traffic |
|`allAccounts.tags` | *array*	| A list of tags for labeling accounts |
|`allAccounts.pending_transactions` | *AccountTransaction*	| The list of current pending transactions for this account |  
|`meta.count` | *int*	| Results count |

### Example
#### Request
```bash
$ curl "https://api.canyan.io/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "{
  allAccounts {
    id
    account_tag
    name
    type
    balance
    linked_accounts {
      account_tag
      name
      type
      balance
    }
    max_pending_transactions
    notification_email
    notification_mobile
    carrier_tags
    carrier_tags_override
    pricelist_tags
    tags
  }
  meta: _allAccountsMeta(page: 0, perPage: 10, sortField: "id", sortOrder: "asc") {
    count
  }
}" }
EOF
```

#### Response
```bash
HTTP/1.1 200 OK
Content-Type: application/json
{
  "data": {
    "allAccounts": [
      {
        "id": "ac8606db-89a7-45ae-9c63-808d6313e2b1",
        "account_tag": "100",
        "name": "My first account",
        "type": "POSTPAID",
        "balance": 1000,
        "linked_accounts": [],
        "max_pending_transactions": 10,
        "notification_email": "alex@canyan.io",
        "notification_mobile": "00385911231234",
        "carrier_tags": null,
        "carrier_tags_override": null,
        "pricelist_tags": [
          "pricelist2"
        ],
        "tags": null
      },
      {
        "id": "b76e706a-5e33-4d5e-baf8-822c90ee3db5",
        "account_tag": "101",
        "name": "My second account",
        "type": "PREPAID",
        "balance": 100,
        "linked_accounts": [],
        "max_pending_transactions": 2,
        "notification_email": "alex@canyan.io",
        "notification_mobile": "00385911231234",
        "carrier_tags": null,
        "carrier_tags_override": null,
        "pricelist_tags": [
          "pricelist1"
        ],
        "tags": null
      }
    ],
    "meta": {
      "count": 2
    }
  }
}
```


## Get specific Account
### Request headers
```Content-Type	application/json```

### Request parameters
| Parameter | type | description |
|-|-|-|
|`allAccounts.filter.id`	| *objectid* | Unique id of the account to fetch |
|`allAccounts.filter.ids`	| *array* | Array of unique ids to fetch |
|`allAccounts.filter.account_tag` | *string*	| Filter accounts by tag |
|`allAccounts.filter.customer_tag` | *string*	| Filter accounts by specific customer tag |
|`allAccounts.filter.type` | *AccountType* | Get specific type of account (PREPAID / POSTPAID) |
|`allAccounts.filter.active` | *boolean*	| Filter by active account |
|`allAccounts.filter.with_pending_transactions` | *boolean*	| Account with pending transactions |
|`allAccounts.filter.with_long_running_transactions` | *boolean*	| Account with long running transactions |

### Response
| Field | type | description |
|-|-|-|
|`allAccounts.id`	| *objectid* | Unique identifyer of the account |
|`allAccounts.account_tag` | *string*	| Identifyer of the account |
|`allAccounts.type` | *AccountType* | The type of the account (PREPAID / POSTPAID) |
|`allAccounts.balance` | *BigInt* | The balance of the account |
|`allAccounts.active` | *boolean*	| Is the account active? Default to true |
|`allAccounts.max_pending_transactions` | *int*	| The maximum number of active calls the account can make and recieve (outbound and inbound) |
|`allAccounts.name` | *string*	| Descriptive name of the account |
|`allAccounts.notification_email` | *string*	| The email the alerts should be sent to |
|`allAccounts.notification_mobile` | *string*	| The mobile phone an SMS alert should be sent to |
|`allAccounts.carrier_tags` | *array*	| List of preferred carriers for this account (prepended to the LCR for example) |
|`allAccounts.carrier_tags_override` | *array*	| List of carriers to force (other LCR carriers for example are ignored) |
|`allAccounts.customer_tag` | *string*	| A customer id this account is associated with |
|`allAccounts.linked_accounts` | *array*	| A list of parent accounts |
|`allAccounts.pricelist_tags` | *array*	| A list of pricelists to apply to this account traffic |
|`allAccounts.tags` | *array*	| A list of tags for labeling accounts |
|`allAccounts.pending_transactions` | *AccountTransaction*	| The list of current pending transactions for this account |  

### Example
#### Request
```bash
$ curl "https://api.canyan.io/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "{
  allAccounts(filter: { active:true }) {
    id
    account_tag
    name
    type
    balance
    max_pending_transactions
    notification_email
    notification_mobile
    carrier_tags
    carrier_tags_override
    pricelist_tags
    tags
  }
}"
}
EOF
```

#### Response
```bash
HTTP/1.1 200 OK
Content-Type: application/json
{
  "data": {
    "allAccounts": [
      {
        "id": "ac8606db-89a7-45ae-9c63-808d6313e2b1",
        "account_tag": "100",
        "name": "My first account",
        "type": "POSTPAID",
        "balance": 1000,
        "max_pending_transactions": 10,
        "notification_email": "alex@canyan.io",
        "notification_mobile": "00385911231234",
        "carrier_tags": null,
        "carrier_tags_override": null,
        "pricelist_tags": [
          "pricelist2"
        ],
        "tags": null
      }
    ]
  }
}
```


## Create a new Account
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 

### Request headers
```Content-Type	application/json```

### Request parameters
| Parameter | type | description |
|-|-|-|
|`createAccount.id`	| *objectid* | Unique identifyer of the account |
|`createAccount.account_tag` | *string*	| Identifyer of the account |
|`createAccount.type` | *AccountType* | The type of the account (PREPAID / POSTPAID) |
|`createAccount.balance` | *BigInt* | The balance of the account |
|`createAccount.active` | *boolean*	| Is the account active? Default to true |
|`createAccount.max_pending_transactions` | *int*	| The maximum number of active calls the account can make and recieve (outbound and inbound) |
|`createAccount.name` | *string*	| Descriptive name of the account |
|`createAccount.notification_email` | *string*	| The email the alerts should be sent to |
|`createAccount.notification_mobile` | *string*	| The mobile phone an SMS alert should be sent to |
|`createAccount.carrier_tags` | *array*	| List of preferred carriers for this account (prepended to the LCR for example) |
|`createAccount.carrier_tags_override` | *array*	| List of carriers to force (other LCR carriers for example are ignored) |
|`createAccount.customer_tag` | *string*	| A customer id this account is associated with |
|`createAccount.linked_accounts` | *array*	| A list of parent accounts |
|`createAccount.pricelist_tags` | *array*	| A list of pricelists to apply to this account traffic |
|`createAccount.tags` | *array*	| A list of tags for labeling accounts |

### Response
| Field | type | description |
|-|-|-|
|`createAccount.id`	| *objectid* | Unique identifyer of the account |
|`createAccount.account_tag` | *string*	| Identifyer of the account |
|`createAccount.type` | *AccountType* | The type of the account (PREPAID / POSTPAID) |
|`createAccount.balance` | *BigInt* | The balance of the account |
|`createAccount.active` | *boolean*	| Is the account active? Default to true |
|`createAccount.max_pending_transactions` | *int*	| The maximum number of active calls the account can make and recieve (outbound and inbound) |
|`createAccount.name` | *string*	| Descriptive name of the account |
|`createAccount.notification_email` | *string*	| The email the alerts should be sent to |
|`createAccount.notification_mobile` | *string*	| The mobile phone an SMS alert should be sent to |
|`createAccount.carrier_tags` | *array*	| List of preferred carriers for this account (prepended to the LCR for example) |
|`createAccount.carrier_tags_override` | *array*	| List of carriers to force (other LCR carriers for example are ignored) |
|`createAccount.customer_tag` | *string*	| A customer id this account is associated with |
|`createAccount.linked_accounts` | *array*	| A list of parent accounts |
|`createAccount.pricelist_tags` | *array*	| A list of pricelists to apply to this account traffic |
|`createAccount.tags` | *array*	| A list of tags for labeling accounts |
|`createAccount.pending_transactions` | *AccountTransaction*	| The list of current pending transactions for this account |  

### Example
#### Request
```bash
$ curl "https://api.canyan.io/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <your-token-here>" \
  --data @- <<EOF
{"query": "mutation {
  createAccount(
    account_tag: "100",
    type: POSTPAID,
    balance: 1000,
    max_pending_transactions: 10,
    name: "My first account",
    notification_mobile: "00385911231234",
		notification_email: "alex@canyan.io",
    active: true,
    pricelist_tags: ["pricelist2"]
  ) {
    id
    account_tag
    name
    type
    balance
    linked_accounts {
			account_tag
      name
      type
      balance
		}
    max_pending_transactions
    notification_email
    notification_mobile
    carrier_tags
    carrier_tags_override
    pricelist_tags
    tags
  }
}"
}
EOF
```

#### Response
```bash
HTTP/1.1 200 OK
Content-Type: application/json
{
  "data": {
    "createAccount": {
      "id": "ac8606db-89a7-45ae-9c63-808d6313e2b1",
      "account_tag": "100",
      "name": "My first account",
      "type": "POSTPAID",
      "balance": 1000,
      "linked_accounts": [],
      "max_pending_transactions": 10,
      "notification_email": "alex@canyan.io",
      "notification_mobile": "00385911231234",
      "carrier_tags": null,
      "carrier_tags_override": null,
      "pricelist_tags": [
        "pricelist2"
      ],
      "tags": null
    }
  }
}
```


## Update an Account
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 

### Request headers
```Content-Type	application/json```

### Request parameters
| Parameter | type | description |
|-|-|-|
|`updateAccount.id`	| *objectid* | Unique identifyer of the account |
|`updateAccount.account_tag` | *string*	| Identifyer of the account |
|`updateAccount.type` | *AccountType* | The type of the account (PREPAID / POSTPAID) |
|`updateAccount.balance` | *BigInt* | The balance of the account |
|`updateAccount.active` | *boolean*	| Is the account active? Default to true |
|`updateAccount.max_pending_transactions` | *int*	| The maximum number of active calls the account can make and recieve (outbound and inbound) |
|`updateAccount.name` | *string*	| Descriptive name of the account |
|`updateAccount.notification_email` | *string*	| The email the alerts should be sent to |
|`updateAccount.notification_mobile` | *string*	| The mobile phone an SMS alert should be sent to |
|`updateAccount.carrier_tags` | *array*	| List of preferred carriers for this account (prepended to the LCR for example) |
|`updateAccount.carrier_tags_override` | *array*	| List of carriers to force (other LCR carriers for example are ignored) |
|`updateAccount.customer_tag` | *string*	| A customer id this account is associated with |
|`updateAccount.linked_accounts` | *array*	| A list of parent accounts |
|`updateAccount.pricelist_tags` | *array*	| A list of pricelists to apply to this account traffic |
|`updateAccount.tags` | *array*	| A list of tags for labeling accounts |

### Response
| Field | type | description |
|-|-|-|
|`updateAccount.id`	| *objectid* | Unique identifyer of the account |
|`updateAccount.account_tag` | *string*	| Identifyer of the account |
|`updateAccount.type` | *AccountType* | The type of the account (PREPAID / POSTPAID) |
|`updateAccount.balance` | *BigInt* | The balance of the account |
|`updateAccount.active` | *boolean*	| Is the account active? Default to true |
|`updateAccount.max_pending_transactions` | *int*	| The maximum number of active calls the account can make and recieve (outbound and inbound) |
|`updateAccount.name` | *string*	| Descriptive name of the account |
|`updateAccount.notification_email` | *string*	| The email the alerts should be sent to |
|`updateAccount.notification_mobile` | *string*	| The mobile phone an SMS alert should be sent to |
|`updateAccount.carrier_tags` | *array*	| List of preferred carriers for this account (prepended to the LCR for example) |
|`updateAccount.carrier_tags_override` | *array*	| List of carriers to force (other LCR carriers for example are ignored) |
|`updateAccount.customer_tag` | *string*	| A customer id this account is associated with |
|`updateAccount.linked_accounts` | *array*	| A list of parent accounts |
|`updateAccount.pricelist_tags` | *array*	| A list of pricelists to apply to this account traffic |
|`updateAccount.tags` | *array*	| A list of tags for labeling accounts |
|`updateAccount.pending_transactions` | *AccountTransaction*	| The list of current pending transactions for this account |  

### Example
#### Request
```bash
$ curl "https://api.canyan.io/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "mutation {
  updateAccount(
    account_tag: "100",
    type: PREPAID,
    balance: 10,
    max_pending_transactions: 2,
    name: "My updated account",
    notification_mobile: "00385911231234",
		notification_email: "alex@canyan.io",
    active: true,
    pricelist_tags: ["pricelist1"]
  ) {
    id
    account_tag
    name
    type
    balance
    max_pending_transactions
    notification_email
    notification_mobile
    carrier_tags
    carrier_tags_override
    pricelist_tags
    tags
  }
}"
}
EOF
```
#### Response
```bash
HTTP/1.1 200 OK
Content-Type: application/json
{
  "data": {
    "updateAccount": {
      "id": "ac8606db-89a7-45ae-9c63-808d6313e2b1",
      "account_tag": "100",
      "name": "My updated account",
      "type": "PREPAID",
      "balance": 10,
      "max_pending_transactions": 2,
      "notification_email": "alex@canyan.io",
      "notification_mobile": "00385911231234",
      "carrier_tags": null,
      "carrier_tags_override": null,
      "pricelist_tags": [
        "pricelist1"
      ],
      "tags": null
    }
  }
}
```


## Delete an Account
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 

### Request headers
```Content-Type	application/json```

### Request parameters
| Parameter | type | description |
|-|-|-|
|`deleteAccount.id` | *identifyer* | Unique identifyer of the account |
|`deleteAccount.account_tag` | *string* | The tag of the account |

### Response
| Field | type | description |
|-|-|-|
|`deleteAccount.id`	| *objectid* | Unique identifyer of the account being deleted |
|`deleteAccount.account_tag` | *string*	| Identifyer of the account being deleted |
|`deleteAccount.type` | *AccountType* | The type of the account being deleted (PREPAID / POSTPAID) |
|`deleteAccount.balance` | *BigInt* | The balance of the account being deleted |
|`deleteAccount.active` | *boolean*	| Was the account active? Default to true |
|`deleteAccount.max_pending_transactions` | *int*	| The maximum number of active calls the account was able to make and recieve (outbound and inbound) |
|`deleteAccount.name` | *string*	| Descriptive name of the account being deleted |
|`deleteAccount.notification_email` | *string*	| The email the alerts were be sent to |
|`deleteAccount.notification_mobile` | *string*	| The mobile phone an SMS alert were be sent to |
|`deleteAccount.carrier_tags` | *array*	| List of preferred carriers for this account (prepended to the LCR for example) |
|`deleteAccount.carrier_tags_override` | *array*	| List of carriers to force (other LCR carriers for example are ignored) |
|`deleteAccount.customer_tag` | *string*	| A customer id this account was associated with |
|`deleteAccount.linked_accounts` | *array*	| A list of parent accounts |
|`deleteAccount.pricelist_tags` | *array*	| A list of pricelists to apply to this account traffic |
|`deleteAccount.tags` | *array*	| A list of tags for labeling accounts |
|`deleteAccount.pending_transactions` | *AccountTransaction*	| The list of current pending transactions for the account being deleted |  

### Example
#### Request
```bash
$ curl "https://api.canyan.io/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "mutation {
  deleteAccount( account_tag: "100") {
    id
    account_tag
    name
    type
    balance
    max_pending_transactions
    notification_email
    notification_mobile
    carrier_tags
    carrier_tags_override
    pricelist_tags
    tags
  }
}"
}
EOF
```

#### Response
```bash
HTTP/1.1 200 OK
Content-Type: application/json
{
  "data": {
    "deleteAccount": {
      "id": "ac8606db-89a7-45ae-9c63-808d6313e2b1",
      "account_tag": "100",
      "name": "My updated account",
      "type": "PREPAID",
      "balance": 10,
      "max_pending_transactions": 2,
      "notification_email": "alex@canyan.io",
      "notification_mobile": "00385911231234",
      "carrier_tags": null,
      "carrier_tags_override": null,
      "pricelist_tags": [
        "pricelist1"
      ],
      "tags": null
    }
  }
}
```
