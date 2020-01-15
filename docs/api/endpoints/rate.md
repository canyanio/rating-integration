# Rate
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 

## Get all Rates
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 

### Request headers
```Content-Type	application/json```

### Request parameters
| Parameter | type | description |
|-|-|-|
|`_allPricelistRates.page`| *int* | page number, starting from zero |
|`_allPricelistRates.perPage` |	*int*	| number of items returned per page |
|`_allPricelistRates.sortField`	| *str*	| field used to sort the returned items, defaults to *id* |
|`_allPricelistRates.sortOrder`	| *str*	| asc or desc, defaults to *asc* |

### Response
| Field | type | description |
|-|-|-|
|`allPricelistRates.id`	| *objectid* | Identifier of the pricelist rate |
|`allPricelistRates.pricelist_tag` | *string*	| The tag of the associated pricelist |
|`allPricelistRates.carrier_tag` | *string* | The carrier of the pricelist rate |
|`allPricelistRates.prefix` | *string* | The prefix to trigger this pricelist rate |
|`allPricelistRates.datetime_start` | *datetime* | The date and time this pricelist rate is active from |
|`allPricelistRates.datetime_end` | *datetime* | The date and time this pricelist rate is active to |
|`allPricelistRates.connect_fee` | *int* | The one time fee triggered on connection |
|`allPricelistRates.rate` | *int* | The rate applied to this destination prefix |
|`allPricelistRates.rate_increment` | *int* | The time span the rate is incremented (every x seconds) |
|`allPricelistRates.interval_start` | *int* | The interval in seconds this rate starts to be applied |
|`allPricelistRates.description` | *string* | A brief description of this pricelist rate |
|`allPricelistRates.meta.count` | *int*	| Results count |

### Example
#### Request
```bash
curl "https://api.canyan.io/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "{
  allPricelistRates {
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
    "allPricelists": [
      {
        "id": "20648787-4958-4928-9fd3-c926d7cec159",
        "pricelist_tag": "pricelist2",
        "name": "Pricelist 2",
        "currency": "USD"
      },
      {
        "id": "58d16ce8-30ed-449d-a81c-c4f069ba6eff",
        "pricelist_tag": "pricelist1",
        "name": "Pricelist One",
        "currency": "EUR"
      }
    ],
    "meta": {
      "count": 2
    }
  }
}
```


## Get specific Pricelist Rate details
### Request headers
```Content-Type	application/json```

### Request parameters
| Parameter | type | description |
|-|-|-|
|`allPricelistRates.filter.id`	| *objectid* | Identifier of the pricelist rate |
|`allPricelistRates.filter.ids` | *array* | Array of identifiers of the pricelist rate to fetch |
|`allPricelistRates.filter.pricelist_id` | *array* | Filter pricelist rate by pricelist id |
|`allPricelistRates.filter.pricelist_tag` | *array* | Filter pricelist rate by pricelist tag |
|`allPricelistRates.filter.carrier_id` | *array* | Filter pricelist rate by carrier ids |
|`allPricelistRates.filter.carrier_tag` | *array* | Filter pricelist rate by carrier tag |
|`allPricelistRates.filter.prefix` | *array* | Filter pricelist rate by prefix |

### Response
| Field | type | description |
|-|-|-|
|`allPricelistRates.id`	| *objectid* | Identifier of the pricelist rate |
|`allPricelistRates.pricelist_tag` | *string*	| The tag of the associated pricelist |
|`allPricelistRates.carrier_tag` | *string* | The carrier of the pricelist rate |
|`allPricelistRates.prefix` | *string* | The prefix to trigger this pricelist rate |
|`allPricelistRates.datetime_start` | *datetime* | The date and time this pricelist rate is active from |
|`allPricelistRates.datetime_end` | *datetime* | The date and time this pricelist rate is active to |
|`allPricelistRates.connect_fee` | *int* | The one time fee triggered on connection |
|`allPricelistRates.rate` | *int* | The rate applied to this destination prefix |
|`allPricelistRates.rate_increment` | *int* | The time span the rate is incremented (every x seconds) |
|`allPricelistRates.interval_start` | *int* | The interval in seconds this rate starts to be applied |
|`allPricelistRates.description` | *string* | A brief description of this pricelist rate |
|`allPricelistRates.meta.count` | *int*	| Results count |

### Example
#### Request
```bash
curl "https://api.canyan.io/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "{
  allPricelistRates(filter: {prefix: \"36\", carrier_tag:\"carrier2\"}) {
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
    "allPricelistRates": [
      {
        "id": "73b52d52-de9b-48f8-a40a-d879eecaeb4b",
        "pricelist_tag": "pricelist1",
        "carrier_tag": "carrier2",
        "prefix": "36",
        "datetime_start": null,
        "datetime_end": null,
        "connect_fee": 0,
        "rate": 20,
        "rate_increment": 60,
        "interval_start": 60,
        "description": "Hungary"
      }
    ]
  }
}
```


## Create a new Pricelist Rate
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 

### Request headers
```Content-Type	application/json```

### Request parameters
| Parameter | type | description |
|-|-|-|
|`createPricelistRate.id`	| *objectid* | Unique identifyer of the pricelist rate (if not provided an uuid4 will be generated automatically - best option) |
|`createPricelistRate.pricelist_tag` | *string*	| The tag of the associated pricelist |
|`createPricelistRate.carrier_tag` | *string* | The carrier of the pricelist rate |
|`createPricelistRate.prefix` | *string* | The prefix to trigger this pricelist rate |
|`createPricelistRate.datetime_start` | *datetime* | The date and time this pricelist rate is active from |
|`createPricelistRate.datetime_end` | *datetime* | The date and time this pricelist rate is active to |
|`createPricelistRate.connect_fee` | *int* | The one time fee triggered on connection |
|`createPricelistRate.rate` | *int* | The rate applied to this destination prefix |
|`createPricelistRate.rate_increment` | *int* | The time span the rate is incremented (every x seconds) |
|`createPricelistRate.interval_start` | *int* | The interval in seconds this rate starts to be applied |
|`createPricelistRate.description` | *string* | A brief description of this pricelist rate |

### Response
| Field | type | description |
|-|-|-|
|`createPricelistRate.id`	| *objectid* | Identifier of the pricelist rate |
|`createPricelistRate.pricelist_tag` | *string*	| The tag of the associated pricelist |
|`createPricelistRate.carrier_tag` | *string* | The carrier of the pricelist rate |
|`createPricelistRate.prefix` | *string* | The prefix to trigger this pricelist rate |
|`createPricelistRate.datetime_start` | *datetime* | The date and time this pricelist rate is active from |
|`createPricelistRate.datetime_end` | *datetime* | The date and time this pricelist rate is active to |
|`createPricelistRate.connect_fee` | *int* | The one time fee triggered on connection |
|`createPricelistRate.rate` | *int* | The rate applied to this destination prefix |
|`createPricelistRate.rate_increment` | *int* | The time span the rate is incremented (every x seconds) |
|`createPricelistRate.interval_start` | *int* | The interval in seconds this rate starts to be applied |
|`createPricelistRate.description` | *string* | A brief description of this pricelist rate |

### Example
#### Request
```bash
curl "https://api.canyan.io/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "mutation {
  createPricelistRate(
        pricelist_tag: \"pricelist1\",
        carrier_tag: \"carrier1\",
        prefix: \"49\",
        connect_fee: 0,
        rate: 20,
        rate_increment: 60,
        interval_start: 60,
        description: \"Germany\"
  ) {
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
    "createPricelistRate": {
      "id": "a82d0e60-1f87-406f-b250-46ca972861c6",
      "pricelist_tag": "pricelist1",
      "carrier_tag": "carrier1",
      "prefix": "49",
      "datetime_start": null,
      "datetime_end": null,
      "connect_fee": 0,
      "rate": 20,
      "rate_increment": 60,
      "interval_start": 60,
      "description": "Germany"
    }
  }
}
```


## Update a Pricelist Rate
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 

### Request headers
```Content-Type	application/json```

### Request parameters
| Parameter | type | description |
|-|-|-|
|`updatePricelistRate.id`	| *objectid* | Unique identifyer of the pricelist rate |
|`updatePricelistRate.pricelist_tag` | *string*	| The tag of the associated pricelist |
|`updatePricelistRate.carrier_tag` | *string* | The carrier of the pricelist rate |
|`updatePricelistRate.prefix` | *string* | The prefix to trigger this pricelist rate |
|`updatePricelistRate.datetime_start` | *datetime* | The date and time this pricelist rate is active from |
|`updatePricelistRate.datetime_end` | *datetime* | The date and time this pricelist rate is active to |
|`updatePricelistRate.connect_fee` | *int* | The one time fee triggered on connection |
|`updatePricelistRate.rate` | *int* | The rate applied to this destination prefix |
|`updatePricelistRate.rate_increment` | *int* | The time span the rate is incremented (every x seconds) |
|`updatePricelistRate.interval_start` | *int* | The interval in seconds this rate starts to be applied |
|`updatePricelistRate.description` | *string* | A brief description of this pricelist rate |

### Response
| Field | type | description |
|-|-|-|
|`updatePricelistRate.id`	| *objectid* | Identifier of the pricelist rate |
|`updatePricelistRate.pricelist_tag` | *string*	| The tag of the associated pricelist |
|`updatePricelistRate.carrier_tag` | *string* | The carrier of the pricelist rate |
|`updatePricelistRate.prefix` | *string* | The prefix to trigger this pricelist rate |
|`updatePricelistRate.datetime_start` | *datetime* | The date and time this pricelist rate is active from |
|`updatePricelistRate.datetime_end` | *datetime* | The date and time this pricelist rate is active to |
|`updatePricelistRate.connect_fee` | *int* | The one time fee triggered on connection |
|`updatePricelistRate.rate` | *int* | The rate applied to this destination prefix |
|`updatePricelistRate.rate_increment` | *int* | The time span the rate is incremented (every x seconds) |
|`updatePricelistRate.interval_start` | *int* | The interval in seconds this rate starts to be applied |
|`updatePricelistRate.description` | *string* | A brief description of this pricelist rate |

### Example
#### Request
```bash
curl "https://api.canyan.io/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "mutation {
  updatePricelistRate(
    pricelist_tag: \"pricelist1\",
    carrier_tag: \"carrier1\",
    prefix: \"49\",
    connect_fee: 0,
    rate: 10,
    rate_increment: 60,
    interval_start: 0,
    description: \"Germany updated\"
  ) {
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
    "updatePricelistRate": {
      "id": "a82d0e60-1f87-406f-b250-46ca972861c6",
      "pricelist_tag": "pricelist1",
      "carrier_tag": "carrier1",
      "prefix": "49",
      "datetime_start": null,
      "datetime_end": null,
      "connect_fee": 0,
      "rate": 10,
      "rate_increment": 60,
      "interval_start": 0,
      "description": "Germany updated"
    }
  }
}
```


## Delete a Pricelist Rate
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 

### Request headers
```Content-Type	application/json```

### Request parameters
| Parameter | type | description |
|-|-|-|
|`deletePricelistRate.id`	| *objectid* | Unique identifyer of the pricelist rate to be deleted |
|`deletePricelistRate.pricelist_tag` | *string*	| The tag of the associated pricelist to be deleted |
|`deletePricelistRate.carrier_tag` | *string* | The carrier of the pricelist rate to delete|
|`deletePricelistRate.prefix` | *string* | The prefix to trigger this pricelist rate to delete |

### Response
| Field | type | description |
|-|-|-|
|`deletePricelistRate.id`	| *objectid* | Identifier of the pricelist rate just deleted |
|`deletePricelistRate.pricelist_tag` | *string*	| The tag of the associated pricelist of the deleted pricelist rate |
|`deletePricelistRate.carrier_tag` | *string* | The carrier of the deleted pricelist rate |
|`deletePricelistRate.prefix` | *string* | The prefix that triggered the deleted pricelist rate |
|`deletePricelistRate.datetime_start` | *datetime* | The date and time the deleted pricelist rate was active from |
|`deletePricelistRate.datetime_end` | *datetime* | The date and time the deleted pricelist rate was active to |
|`deletePricelistRate.connect_fee` | *int* | The one time fee triggered on connection of the deleted pricelist rate |
|`deletePricelistRate.rate` | *int* | The rate that was applied to the deleted pricelist rate destination prefix |
|`deletePricelistRate.rate_increment` | *int* | The time span the rate of the deleted pricelist rate was incremented (every x seconds) |
|`deletePricelistRate.interval_start` | *int* | The interval in seconds the deleted pricelist rate started to be applied |
|`deletePricelistRate.description` | *string* | A brief description of the pricelist rate just deleted |

### Example
#### Request
```bash
curl "https://api.canyan.io/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "mutation {
  deletePricelistRate(id: "a82d0e60-1f87-406f-b250-46ca972861c6") {
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
    "deletePricelistRate": {
      "id": "a82d0e60-1f87-406f-b250-46ca972861c6",
      "pricelist_tag": "pricelist1",
      "carrier_tag": "carrier1",
      "prefix": "49",
      "datetime_start": null,
      "datetime_end": null,
      "connect_fee": 0,
      "rate": 10,
      "rate_increment": 60,
      "interval_start": 0,
      "description": "Germany updated"
    }
  }
}
```
