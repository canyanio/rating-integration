# Transaction
This model holds the consolidated transactions performed by an account. All the data in this model is immutable by the rating engine and contains all the data used to calculate the rate at the moment the transaction was performed without relating to external data.

## Get all the Transactions
This method is used to list all the transactions

### Request headers
```Content-Type	application/json```

### Request parameters
| Parameter | type | description |
|-|-|-|
|`_allTransactions.page`| *int* | page number, starting from zero |
|`_allTransactions.perPage` |	*int*	| number of items returned per page |
|`_allTransactions.sortField`	| *str*	| field used to sort the returned items, defaults to *id* |
|`_allTransactions.sortOrder`	| *str*	| asc or desc, defaults to *asc* |

### Response
| Field | type | description |
|-|-|-|
|`allTransactions.id`	| *objectid* | Identifier of the transaction |
|`allTransactions.transaction_tag` | *string*	| The unique tag of the transaction |
|`allTransactions.account_tag` | *string* | The account tag associated with the transaction |
|`allTransactions.account` | *Account* | The object [account](./account.md) |
|`allTransactions.source` | *string* | The source of the transaction |
|`allTransactions.source_ip` | *string* | The IP address of the source of the transaction |
|`allTransactions.destination` | *string* | The destination of the transaction |
|`allTransactions.carrier_ip` | *string* | The IP address of the carrier used |
|`allTransactions.tags` | *array* | Tags associated with this transaction |
|`allTransactions.authorized` | *boolean* | Was this transaction authorized |
|`allTransactions.unauthorized_reason` | *string* | If unauthorized, what was the reason? |
|`allTransactions.destination_rate` | *PricelistRate* | The object [Rate](./rate.md) |
|`allTransactions.timestamp_auth` | *datetime* | When was the authorization performed for this transaction |
|`allTransactions.timestamp_begin` | *datetime* | When the transaction started |
|`allTransactions.timestamp_end` | *datetime* | When the transaction ended |
|`allTransactions.inbound` | *boolean* | Is this an inbound transaction? |
|`allTransactions.duration` | *int* | The duration of the transaction |
|`allTransactions.fee` | *int* | The calculated fee of the transaction |
|`allTransactions.meta.count` | *int*	| Results count |


### Example
#### Request
```bash
curl "https://api.canyan.io/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "{
  allTransactions {
    id
    transaction_tag
    account_tag
    authorized
    inbound
    failed
    duration
    fee
  }
  meta: _allPricelistsMeta(page: 0, perPage: 10, sortField: "id", sortOrder: "asc") {
      count
  }
}
" }
EOF
```

#### Response
```bash
HTTP/1.1 200 OK
Content-Type: application/json
{
  "data": {
    "allTransactions": [
      {
        "id": "469f8e15-f0a2-4f7f-92eb-c52d2d491b24",
        "transaction_tag": "100",
        "account_tag": "1000",
        "authorized": true,
        "inbound": false,
        "duration": 10,
        "fee": 20,
      },
      {
        "id": "1293ha-h0a3-2f6f-a398-a9382f744bdc",
        "transaction_tag": "101",
        "account_tag": "1000",
        "authorized": true,
        "inbound": true,
        "duration": 0,
        "fee": 0,
      }
    ],
    "meta": {
      "count": 2
    }
  }
}
```


## Get specific Transaction detail
This method is used to fetch a specific transaction either by id or a combination of transaction and account tag.

### Request headers
```Content-Type	application/json```

### Request parameters
| Parameter | type | description |
|-|-|-|
|`Transaction.id`	| *objectid* | Identifier of the transaction |
|`Transaction.transaction_tag` | *string* | The transaction tag |
|`Transaction.account_tag` | *string* | The account tag |


### Response
| Field | type | description |
|-|-|-|
|`Transaction.id`	| *objectid* | Identifier of the transaction |
|`Transaction.transaction_tag` | *string*	| The unique tag of the transaction |
|`Transaction.account_tag` | *string* | The account tag associated with the transaction |
|`Transaction.account` | *Account* | The object [account](./account.md) |
|`Transaction.source` | *string* | The source of the transaction |
|`Transaction.source_ip` | *string* | The IP address of the source of the transaction |
|`Transaction.destination` | *string* | The destination of the transaction |
|`Transaction.carrier_ip` | *string* | The IP address of the carrier used |
|`Transaction.tags` | *array* | Tags associated with this transaction |
|`Transaction.authorized` | *boolean* | Was this transaction authorized |
|`Transaction.unauthorized_reason` | *string* | If unauthorized, what was the reason? |
|`Transaction.destination_rate` | *PricelistRate* | The object [Rate](./rate.md) |
|`Transaction.timestamp_auth` | *datetime* | When was the authorization performed for this transaction |
|`Transaction.timestamp_begin` | *datetime* | When the transaction started |
|`Transaction.timestamp_end` | *datetime* | When the transaction ended |
|`Transaction.inbound` | *boolean* | Is this an inbound transaction? |
|`Transaction.duration` | *int* | The duration of the transaction |
|`Transaction.fee` | *int* | The calculated fee of the transaction |

### Example
#### Request
```bash
curl "https://api.canyan.io/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "  Transaction(
  transaction_tag: \"transaction_1\", 
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
    unauthorized_reason
    timestamp_auth
    timestamp_begin
    timestamp_end
    inbound
    duration
    fee
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
    "Transaction": [
      {
        "id": "469f8e15-f0a2-4f7f-92eb-c52d2d491b24",
        "transaction_tag": "100",
        "account_tag": "1000",
        "source": "39040123000",
        "source_ip": "10.0.0.1",
        "destination": "39040123123",
        "destination_rate" {
          "pricelist_tag": "pricelist1",
          "carrier_tag": "carrier1",
          "prefix": "39",
          "connect_fee": 0,
          "rate": 10,
          "rate_increment": 60,
          "interval_start": 0
        }
        "carrier_ip": "10.0.0.6",
        "authorized": true,
        "timestamp_auth": "2019-08-15T21:26:17Z",
        "timestamp_begin": "2019-08-15T21:26:20Z",
        "timestamp_end": "2019-08-15T21:26:50Z",
        "inbound": false,
        "duration": 30,
        "fee": 20,
      }
    ]
  }
}
```


## Create a Transaction
This method is used to create a transaction record.

### Request headers
```Content-Type	application/json```

### Request parameters
| Parameter | type | description |
|-|-|-|
|`createTransaction.id`	| *objectid* | Identifier of the transaction |
|`createTransaction.transaction_tag` | *string*	| The unique tag of the transaction |
|`createTransaction.account_tag` | *string* | The account tag associated with the transaction |
|`createTransaction.account` | *Account* | The object [account](./account.md) |
|`createTransaction.source` | *string* | The source of the transaction |
|`createTransaction.source_ip` | *string* | The IP address of the source of the transaction |
|`createTransaction.destination` | *string* | The destination of the transaction |
|`createTransaction.carrier_ip` | *string* | The IP address of the carrier used |
|`createTransaction.tags` | *array* | Tags associated with this transaction |
|`createTransaction.authorized` | *boolean* | Was this transaction authorized |
|`createTransaction.unauthorized_reason` | *string* | If unauthorized, what was the reason? |
|`createTransaction.destination_rate` | *InputAccountPricelistRate* | The object [Rate](./rate.md) |
|`createTransaction.timestamp_auth` | *datetime* | When was the authorization performed for this transaction |
|`createTransaction.timestamp_begin` | *datetime* | When the transaction started |
|`createTransaction.timestamp_end` | *datetime* | When the transaction ended |
|`createTransaction.inbound` | *boolean* | Is this an inbound transaction? |
|`createTransaction.duration` | *int* | The duration of the transaction |
|`createTransaction.fee` | *int* | The calculated fee of the transaction |


### Response
| Field | type | description |
|-|-|-|
|`createTransaction.id`	| *objectid* | Identifier of the transaction |
|`createTransaction.transaction_tag` | *string*	| The unique tag of the transaction |
|`createTransaction.account_tag` | *string* | The account tag associated with the transaction |
|`createTransaction.account` | *Account* | The object [account](./account.md) |
|`createTransaction.source` | *string* | The source of the transaction |
|`createTransaction.source_ip` | *string* | The IP address of the source of the transaction |
|`createTransaction.destination` | *string* | The destination of the transaction |
|`createTransaction.carrier_ip` | *string* | The IP address of the carrier used |
|`createTransaction.tags` | *array* | Tags associated with this transaction |
|`createTransaction.authorized` | *boolean* | Was this transaction authorized |
|`createTransaction.unauthorized_reason` | *string* | If unauthorized, what was the reason? |
|`createTransaction.destination_rate` | *PricelistRate* | The object [Rate](./rate.md) |
|`createTransaction.timestamp_auth` | *datetime* | When was the authorization performed for this transaction |
|`createTransaction.timestamp_begin` | *datetime* | When the transaction started |
|`createTransaction.timestamp_end` | *datetime* | When the transaction ended |
|`createTransaction.inbound` | *boolean* | Is this an inbound transaction? |
|`createTransaction.duration` | *int* | The duration of the transaction |
|`createTransaction.fee` | *int* | The calculated fee of the transaction |

### Example
#### Request
```bash
curl "http://localhost:8000/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "mutation {
  createTransaction(
    transaction_tag: \"transaction1\",
    account_tag: \"100\",
    destination: \"39040123100\",
    carrier_ip: \"10.0.0.1\",
    destination_rate: {
      pricelist_tag: \"pricelist1\",
      prefix: \"39\",
      connect_fee: 0,
      rate: 20,
      rate_increment: 60,
      interval_start: 0,
      carrier_tag: \"carrier1\",
      description: \"Italy fixed\"
    }
    fee: 20,
    authorized: true,
    inbound: false,
    source: \"39040123123\",
    source_ip: \"10.0.0.2\",
    timestamp_auth: \"2019-08-15T21:10:17Z\",
    timestamp_begin: \"2019-08-15T21:20:17Z\",
    timestamp_end: \"2019-08-15T22:00:17Z\",
    duration: 40
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
    duration
    fee
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
    "createTransaction": {
      "id": "07d6415e-84c6-48fe-95be-5012caa9514e",
      "transaction_tag": "transaction1",
      "account_tag": "100",
      "source": "39040123123",
      "source_ip": "10.0.0.2",
      "destination": "39040123100",
      "destination_rate": {
        "pricelist_tag": "pricelist1",
        "carrier_tag": "carrier1",
        "prefix": "39",
        "connect_fee": 0,
        "rate": 20,
        "rate_increment": 60,
        "interval_start": 0
      },
      "carrier_ip": "10.0.0.1",
      "authorized": true,
      "timestamp_auth": "2019-08-15T21:10:17",
      "timestamp_begin": "2019-08-15T21:20:17",
      "timestamp_end": "2019-08-15T22:00:17",
      "inbound": false,
      "duration": 40,
      "fee": 20
    }
  },
  "errors": null
}
```


## Update a Transaction
This method should not be used but it's available if an update to a transaction is needed.

### Request headers
```Content-Type	application/json```

### Request parameters
| Parameter | type | description |
|-|-|-|
|`updateTransaction.id`	| *objectid* | Identifier of the transaction |
|`updateTransaction.transaction_tag` | *string*	| The unique tag of the transaction |
|`updateTransaction.account_tag` | *string* | The account tag associated with the transaction |
|`updateTransaction.account` | *Account* | The object [account](./account.md) |
|`updateTransaction.source` | *string* | The source of the transaction |
|`updateTransaction.source_ip` | *string* | The IP address of the source of the transaction |
|`updateTransaction.destination` | *string* | The destination of the transaction |
|`updateTransaction.carrier_ip` | *string* | The IP address of the carrier used |
|`updateTransaction.tags` | *array* | Tags associated with this transaction |
|`updateTransaction.authorized` | *boolean* | Was this transaction authorized |
|`updateTransaction.unauthorized_reason` | *string* | If unauthorized, what was the reason? |
|`updateTransaction.destination_rate` | *InputAccountPricelistRate* | The object [Rate](./rate.md) |
|`updateTransaction.timestamp_auth` | *datetime* | When was the authorization performed for this transaction |
|`updateTransaction.timestamp_begin` | *datetime* | When the transaction started |
|`updateTransaction.timestamp_end` | *datetime* | When the transaction ended |
|`updateTransaction.inbound` | *boolean* | Is this an inbound transaction? |
|`updateTransaction.duration` | *int* | The duration of the transaction |
|`updateTransaction.fee` | *int* | The calculated fee of the transaction |


### Response
| Field | type | description |
|-|-|-|
|`updateTransaction.id`	| *objectid* | Identifier of the transaction |
|`updateTransaction.transaction_tag` | *string*	| The unique tag of the transaction |
|`updateTransaction.account_tag` | *string* | The account tag associated with the transaction |
|`updateTransaction.account` | *Account* | The object [account](./account.md) |
|`updateTransaction.source` | *string* | The source of the transaction |
|`updateTransaction.source_ip` | *string* | The IP address of the source of the transaction |
|`updateTransaction.destination` | *string* | The destination of the transaction |
|`updateTransaction.carrier_ip` | *string* | The IP address of the carrier used |
|`updateTransaction.tags` | *array* | Tags associated with this transaction |
|`updateTransaction.authorized` | *boolean* | Was this transaction authorized |
|`updateTransaction.unauthorized_reason` | *string* | If unauthorized, what was the reason? |
|`updateTransaction.destination_rate` | *PricelistRate* | The object [Rate](./rate.md) |
|`updateTransaction.timestamp_auth` | *datetime* | When was the authorization performed for this transaction |
|`updateTransaction.timestamp_begin` | *datetime* | When the transaction started |
|`updateTransaction.timestamp_end` | *datetime* | When the transaction ended |
|`updateTransaction.inbound` | *boolean* | Is this an inbound transaction? |
|`updateTransaction.duration` | *int* | The duration of the transaction |
|`updateTransaction.fee` | *int* | The calculated fee of the transaction |

### Example
#### Request
```bash
curl "http://localhost:8000/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "mutation {
  updateTransaction(
    transaction_tag: \"transaction1\",
    account_tag: \"100\",
    destination: \"39040123101\",
    carrier_ip: \"10.0.0.1\",
    destination_rate: {
      pricelist_tag: \"pricelist1\",
      prefix: \"39\",
      connect_fee: 0,
      rate: 20,
      rate_increment: 60,
      interval_start: 0,
      carrier_tag: \"carrier1\",
      description: \"Italy fixed\"
    }
    fee: 0,
    authorized: true,
    unauthorized_reason: "Unavailable destination"
    inbound: false,
    source: \"39040123123\",
    source_ip: \"10.0.0.2\",
    timestamp_auth: \"2019-08-15T21:10:17Z\",
    timestamp_begin: \"2019-08-15T21:11:17Z\",
    timestamp_end: \"2019-08-15T22:11:17Z\",
    duration: 0
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
    duration
    fee
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
    "updateTransaction": {
      "id": "07d6415e-84c6-48fe-95be-5012caa9514e",
      "transaction_tag": "transaction1",
      "account_tag": "100",
      "source": "39040123123",
      "source_ip": "10.0.0.2",
      "destination": "39040123101",
      "destination_rate": {
        "pricelist_tag": "pricelist1",
        "carrier_tag": "carrier1",
        "prefix": "39",
        "connect_fee": 0,
        "rate": 20,
        "rate_increment": 60,
        "interval_start": 0
      },
      "carrier_ip": "10.0.0.1",
      "authorized": true,
      "unauthorized_reason": "Unavailable destination",
      "timestamp_auth": "2019-08-15T21:10:17",
      "timestamp_begin": "2019-08-15T21:11:17",
      "timestamp_end": "2019-08-15T22:11:17",
      "inbound": false,
      "duration": 0,
      "fee": 0
    }
  },
  "errors": null
}
```


## Delete a Transaction
This method can be used to remove a particular transaction either by id or a combination of account and transaction tag.

### Request headers
```Content-Type	application/json```

### Request parameters
| Parameter | type | description |
|-|-|-|
|`deleteTransaction.id`	| *objectid* | Unique identifyer of the transaction to be deleted |
|`deleteTransaction.account_tag` | *string*	| The tag of the account for the transaction to be deleted |
|`deleteTransaction.transaction_tag` | *string* | The tag of the transaction to delete|

### Response
| Field | type | description |
|-|-|-|
|`deleteTransaction.id`	| *objectid* | Identifier of the transaction |
|`deleteTransaction.transaction_tag` | *string*	| The unique tag of the transaction |
|`deleteTransaction.account_tag` | *string* | The account tag associated with the transaction |
|`deleteTransaction.account` | *Account* | The object [account](./account.md) |
|`deleteTransaction.source` | *string* | The source of the transaction |
|`deleteTransaction.source_ip` | *string* | The IP address of the source of the transaction |
|`deleteTransaction.destination` | *string* | The destination of the transaction |
|`deleteTransaction.carrier_ip` | *string* | The IP address of the carrier used |
|`deleteTransaction.tags` | *array* | Tags associated with this transaction |
|`deleteTransaction.authorized` | *boolean* | Was this transaction authorized |
|`deleteTransaction.unauthorized_reason` | *string* | If unauthorized, what was the reason? |
|`deleteTransaction.destination_rate` | *PricelistRate* | The object [Rate](./rate.md) |
|`deleteTransaction.timestamp_auth` | *datetime* | When was the authorization performed for this transaction |
|`deleteTransaction.timestamp_begin` | *datetime* | When the transaction started |
|`deleteTransaction.timestamp_end` | *datetime* | When the transaction ended |
|`deleteTransaction.inbound` | *boolean* | Is this an inbound transaction? |
|`deleteTransaction.duration` | *int* | The duration of the transaction |
|`deleteTransaction.fee` | *int* | The calculated fee of the transaction |

### Example
#### Request
```bash
curl "https://api.canyan.io/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "mutation {
  deleteTransaction(id: "07d6415e-84c6-48fe-95be-5012caa9514e") {
    id
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

#### Response
```bash
HTTP/1.1 200 OK
Content-Type: application/json
{ 
  "data": {
    "deleteTransaction": {
      "id": "07d6415e-84c6-48fe-95be-5012caa9514e",
      "transaction_tag": "transaction1",
      "account_tag": "100",
      "source": "39040123123",
      "source_ip": "10.0.0.2",
      "destination": "39040123101",
      "destination_rate": {
        "pricelist_tag": "pricelist1",
        "carrier_tag": "carrier1",
        "prefix": "39",
        "connect_fee": 0,
        "rate": 20,
        "rate_increment": 60,
        "interval_start": 0
      },
      "carrier_ip": "10.0.0.1",
      "authorized": true,
      "unauthorized_reason": "Unavailable destination",
      "timestamp_auth": "2019-08-15T21:10:17",
      "timestamp_begin": "2019-08-15T21:11:17",
      "timestamp_end": "2019-08-15T22:11:17",
      "inbound": false,
      "duration": 0,
      "fee": 0
    }
  },
  "errors": null
}
```
