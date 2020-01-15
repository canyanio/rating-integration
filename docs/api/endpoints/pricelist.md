# Pircelist
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 

## Get all Pricelists
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 

### Request headers
```Content-Type	application/json```

### Request parameters
| Parameter | type | description |
|-|-|-|
|`_allPricelistsMeta.page`| *int* | page number, starting from zero |
|`_allPricelistsMeta.perPage` |	*int*	| number of items returned per page |
|`_allPricelistsMeta.sortField`	| *str*	| field used to sort the returned items, defaults to *id* |
|`_allPricelistsMeta.sortOrder`	| *str*	| asc or desc, defaults to *asc* |

### Response
| Field | type | description |
|-|-|-|
|`allPricelists.id`	| *objectid* | Identifier of the pricelist |
|`allPricelists.pricelist_tag` | *string*	| Pricelist tag |
|`allPricelists.name` | *string* | Descriptive name of the pricelist |
|`allPricelists.currency` | *PricelistCurrency* | USD or EUR |
|`allPricelists.meta.count` | *int*	| Results count |

### Example
#### Request
```bash
curl "https://api.canyan.io/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "{
  allPricelists {
    id
    pricelist_tag
    name
    currency
  }
  meta: _allPricelistsMeta(page: 0, perPage: 10, sortField: \"pricelist_tag\", sortOrder: \"asc\") {
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


## Get specific Pricelist details
### Request headers
```Content-Type	application/json```

### Request parameters
| Parameter | type | description |
|-|-|-|
|`allPricelists.filter.id`| *id* | id of the pricelist |
|`allPricelists.filter.ids` |	*array*	| array of pricelist ids to fetch |
|`allPricelists.filter.pricelist_tag`	| *str*	| get a pricelist by it's tag |

### Response
| Field | type | description |
|-|-|-|
|`allPricelists.id`	| *objectid* | Identifier of the pricelist |
|`allPricelists.pricelist_tag` | *string*	| Pricelist tag |
|`allPricelists.name` | *string* | Descriptive name of the pricelist |
|`allPricelists.currency` | *PricelistCurrency* | USD or EUR |
|`allPricelists.meta.count` | *int*	| Results count |

### Example
#### Request
```bash
curl "https://api.canyan.io/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "{
  allPricelists(filter: {pricelist_tag: \"pricelist2\"}) {
    id
    pricelist_tag
    name
    currency
  }
  meta: _allPricelistsMeta(page: 0, perPage: 10, sortField: \"pricelist_tag\", sortOrder: \"asc\") {
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
    "allPricelists": [
      {
        "id": "20648787-4958-4928-9fd3-c926d7cec159",
        "pricelist_tag": "pricelist2",
        "name": "Pricelist 2",
        "currency": "USD"
      }
    ]
  }
}
```


## Create a new Pricelist
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 

### Request headers
```Content-Type	application/json```

### Request parameters
| Parameter | type | description |
|-|-|-|
|`createPricelist.id` | *objectid* | Unique identifyer of the pricelist (if not provided an uuid4 will be generated automatically - best option) |
|`createPricelist.tag` | *string* | Unique tag of the pricelist |
|`createPricelist.name` | *string* | Descriptive name of the Pricelist |
|`createPricelist.currency` | *PricelistCurrency*	| Currency used for this pricelist |


### Response
| Field | type | description |
|-|-|-|
|`createPricelist.id`	| *objectid* | Identifier of the pricelist |
|`createPricelist.pricelist_tag` | *string*	| Pricelist tag |
|`createPricelist.name` | *string* | Descriptive name of the pricelist |
|`createPricelist.currency` | *PricelistCurrency* | USD or EUR |
|`createPricelist.meta.count` | *int*	| Results count |

### Example
#### Request
```bash
curl "https://api.canyan.io/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "mutation {
  createPricelist(pricelist_tag: \"new_pricelist\", name: \"Test pricelist\", currency: EUR) {
    id
    pricelist_tag
    name
    currency
  }
}
"
}
EOF
```

#### Response
```bash
HTTP/1.1 200 OK
Content-Type: application/json
{
  "data": {
    "createPricelist": {
      "id": "f6b0ddff-0d6e-4acf-8fcc-a49409b69003",
      "pricelist_tag": "new_pricelist",
      "name": "Test pricelist",
      "currency": "EUR"
    }
  }
}
```


## Update a Pricelist
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 

### Request headers
```Content-Type	application/json```

### Request parameters
| Parameter | type | description |
|-|-|-|
|`updatePricelist.id` | *objectid* | Unique identifyer of the pricelist (if not provided an uuid4 will be generated automatically - best option) |
|`updatePricelist.tag` | *string* | Unique tag of the pricelist |
|`updatePricelist.name` | *string* | Descriptive name of the Pricelist |
|`updatePricelist.currency` | *PricelistCurrency*	| Currency used for this pricelist |

### Response
| Field | type | description |
|-|-|-|
|`updatePricelist.id`	| *objectid* | Identifier of the pricelist |
|`updatePricelist.pricelist_tag` | *string*	| Pricelist tag |
|`updatePricelist.name` | *string* | Descriptive name of the pricelist |
|`updatePricelist.currency` | *PricelistCurrency* | USD or EUR |

### Example
#### Request
```bash
curl "https://api.canyan.io/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "mutation {
  updatePricelist(pricelist_tag: \"new_pricelist\", name: \"Updated pricelist\", currency: USD) {
    id
    pricelist_tag
    name
    currency
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
    "updatePricelist": {
      "id": "f6b0ddff-0d6e-4acf-8fcc-a49409b69003",
      "pricelist_tag": "new_pricelist",
      "name": "Updated pricelist",
      "currency": "USD"
    }
  }
}
```


## Delete a Pricelist
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 

### Request headers
```Content-Type	application/json```

### Request parameters
| Parameter | type | description |
|-|-|-|
|`deletePricelist.id` | *identifyer* | Unique identifyer of the pricelist |
|`deletePricelist.pricelist_tag` | *string* | The tag of the pricelist to delete |

### Response
| Field | type | description |
|-|-|-|
|`deletePricelist.id`	| *objectid* | Identifier of the deleted pricelist |
|`deletePricelist.pricelist_tag` | *string*	| Unique tag of the pricelist just deleted |
|`deletePricelist.name` | *string* | Descriptive name of the deleted pricelist |
|`deletePricelist.currency` | *PricelistCurrency* | Currency used for the deleted pricelist |

### Example
#### Request
```bash
curl "https://api.canyan.io/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "mutation {
  deletePricelist(pricelist_tag: "new_pricelist") {
    id
    pricelist_tag
    name
    currency
  }
}
"
}
EOF
```

#### Response
```bash
HTTP/1.1 200 OK
Content-Type: application/json
{
  "data": {
    "deletePricelist": {
      "id": "f6b0ddff-0d6e-4acf-8fcc-a49409b69003",
      "pricelist_tag": "new_pricelist",
      "name": "Updated pricelist",
      "currency": "USD"
    }
  }
}
```
