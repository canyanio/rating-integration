# Carrier
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 

## Get all Carriers
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 

### Request headers
```Content-Type	application/json```

### Request parameters
| Parameter | type | description |
|-|-|-|
|`_allCarriersMeta.page`| *int* | page number, starting from zero |
|`_allCarriersMeta.perPage` |	*int*	| number of items returned per page |
|`_allCarriersMeta.sortField`	| *str*	| field used to sort the returned items, defaults to *id* |
|`_allCarriersMeta.sortOrder`	| *str*	| asc or desc, defaults to *asc* |

### Response
| Field | type | description |
|-|-|-|
|`allCarriers.id`	| *objectid* | Identifier of the carrier |
|`allCarriers.carrier_tag` | *string*	| The tag of the carrier |
|`allCarriers.host` | *string* | The carriers's host (hostname or IP) |
|`allCarriers.port` | *int* | The communication endpoint port |
|`allCarriers.protocol` | *CarrierProtocol*	| TCP or UDP protocol |
|`allCarriers.active` | *int*	| Is this carrier enabled? |
|`allCarriers.meta.count` | *int*	| Results count |

### Example
#### Request
```bash
$ curl "https://api.canyan.io/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "{
    allCarriers {
      id
      carrier_tag
      host
      port
      protocol
      active
    }
    meta: _allCarriersMeta(page: 0, perPage: 10, sortField: \"id\", sortOrder: \"asc\") {
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
    "allCarriers": [
      {
        "id": "40419d91-23af-43db-a54a-3744d4f8fb8f",
        "carrier_tag": "carrier1",
        "host": "carrier1.alex.com",
        "port": 5060,
        "protocol": "TCP",
        "active": true
      },
      {
        "id": "6dd0fdee-000d-43ce-9678-821a3ef5f97f",
        "carrier_tag": "carrier2",
        "host": "carrier2.alex.com",
        "port": 5060,
        "protocol": "UDP",
        "active": true
      }
    ],
    "meta": {
      "count": 2
    }
  }
}
```


## Get specific Carrier details
### Request headers
```Content-Type	application/json```

### Request parameters
| Parameter | type | description |
|-|-|-|
|`allCarriers.filter.id`| *id* | id of the carrier |
|`allCarriers.filter.ids` |	*array*	| array of ids to fetch |
|`allCarriers.filter.carrier_tag`	| *array*	| get a carrier by it's tag |

### Response
| Field | type | description |
|-|-|-|
|`allCarriers.id`	| *objectid* | Identifier of the carrier |
|`allCarriers.carrier_tag` | *string*	| The tag of the carrier |
|`allCarriers.host` | *string* | The carriers's host (hostname or IP) |
|`allCarriers.port` | *int* | The communication endpoint port |
|`allCarriers.protocol` | *CarrierProtocol*	| TCP or UDP protocol |
|`allCarriers.active` | *int*	| Is this carrier enabled? |
|`allCarriers.meta.count` | *int*	| Results count |

### Example
#### Request
```bash
$ curl "https://api.canyan.io/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "{
    allCarriers() {
      id
      carrier_tag
      host
      port
      protocol
      active
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
    "allCarriers": [
      {
        "id": "40419d91-23af-43db-a54a-3744d4f8fb8f",
        "carrier_tag": "carrier1",
        "host": "carrier1.alex.com",
        "port": 5060,
        "protocol": "TCP",
        "active": true
      },
      {
        "id": "6dd0fdee-000d-43ce-9678-821a3ef5f97f",
        "carrier_tag": "carrier2",
        "host": "carrier2.alex.com",
        "port": 5060,
        "protocol": "UDP",
        "active": true
      }
    ]
  }
}
```


## Create a new Carrier
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 

### Request headers
```Content-Type	application/json```

### Request parameters
| Parameter | type | description |
|-|-|-|
|`createCarrier.id` | *identifyer* | Unique identifyer of the carrier (if not provided an uuid4 will be generated automatically - best option) |
|`createCarrier.carrier_tag` | *string* | The tag of the carrier |
|`createCarrier.host` | *string* | The carriers's host (hostname or IP) |
|`createCarrier.port` | *int*	| The communication endpoint port |
|`createCarrier.protocol` | *CarrierProtocol* | TCP or UDP protocol |
|`createCarrier.active` | *boolean*	| Should this carrier be enabled? |

### Response
| Field | type | description |
|-|-|-|
|`createCarrier.id` | *objectid* | Identifier of the carrier |
|`createCarrier.carrier_tag` | *string* | The tag of the carrier |
|`createCarrier.host` | *string* | The carriers's host (hostname or IP) |
|`createCarrier.port` | *int* | The communication endpoint port |
|`createCarrier.protocol` | *CarrierProtocol* | TCP or UDP protocol |
|`createCarrier.active` | *int* | Is this carrier enabled? |

### Example
#### Request
```bash
$ curl "https://api.canyan.io/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "mutation {
  createCarrier(carrier_tag: \"alex-carrier1\", host: \"alex.canyan.io\", port: 5060, protocol: TCP, active: true) {
    id
    carrier_tag
    host
    port
    protocol
    active
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
    "createCarrier": {
      "id": "48deac88-1d1b-4680-8b2a-c9af38ae7136",
      "carrier_tag": "alex-carrier1",
      "host": "alex.canyan.io",
      "port": 5060,
      "protocol": "TCP",
      "active": true
    }
  }
}
```


## Update a Carrier
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 

### Request headers
```Content-Type	application/json```

### Request parameters
| Parameter | type | description |
|-|-|-|
|`updateCarrier.id` | *identifyer* | Unique identifyer of the carrier (if not provided an uuid4 will be generated automatically - best option) |
|`updateCarrier.carrier_tag` | *string* | The tag of the carrier |
|`updateCarrier.host` | *string* | The carriers's host (hostname or IP) |
|`updateCarrier.port` | *int*	| The communication endpoint port |
|`updateCarrier.protocol` | *CarrierProtocol* | TCP or UDP protocol |
|`updateCarrier.active` | *boolean*	| Should this carrier be enabled? |

### Response
| Field | type | description |
|-|-|-|
|`updateCarrier.id` | *objectid* | Identifier of the carrier |
|`updateCarrier.carrier_tag` | *string* | The tag of the carrier |
|`updateCarrier.host` | *string* | The carriers's host (hostname or IP) |
|`updateCarrier.port` | *int* | The communication endpoint port |
|`updateCarrier.protocol` | *CarrierProtocol* | TCP or UDP protocol |
|`updateCarrier.active` | *int* | Is this carrier enabled? |

### Example
#### Request
```bash
$ curl "https://api.canyan.io/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "mutation {
  updateCarrier(carrier_tag: \"alex-carrier1\", host: \"alexcarrier.canyan.io\", port: 5061, protocol: UDP, active: false) {
    id
    carrier_tag
    host
    port
    protocol
    active
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
    "updateCarrier": {
      "id": "48deac88-1d1b-4680-8b2a-c9af38ae7136",
      "carrier_tag": "alex-carrier1",
      "host": "alexcarrier.canyan.io",
      "port": 5061,
      "protocol": "UDP",
      "active": false
    }
  }
}
```


## Delete a Carrier
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 

### Request headers
```Content-Type	application/json```

### Request parameters
| Parameter | type | description |
|-|-|-|
|`deleteCarrier.id` | *identifyer* | Unique identifyer of the carrier |
|`deleteCarrier.carrier_tag` | *string* | The tag of the carrier |

### Response
| Field | type | description |
|-|-|-|
|`deleteCarrier.id` | *objectid* | Identifier of the carrier |
|`deleteCarrier.carrier_tag` | *string* | The tag of the carrier |
|`deleteCarrier.host` | *string* | The carriers's host (hostname or IP) |
|`deleteCarrier.port` | *int* | The communication endpoint port |
|`deleteCarrier.protocol` | *CarrierProtocol* | TCP or UDP protocol |
|`deleteCarrier.active` | *int* | Is this carrier enabled? |

### Example
#### Request
```bash
$ curl "https://api.canyan.io/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  --data @- <<EOF
{"query": "mutation {
  deleteCarrier(carrier_tag: \"alex-carrier1\") {
    id
    carrier_tag
    host
    port
    protocol
    active
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
    "deleteCarrier": {
      "id": "48deac88-1d1b-4680-8b2a-c9af38ae7136",
      "carrier_tag": "alex-carrier1",
      "host": "alexcarrier.canyan.io",
      "port": 5061,
      "protocol": "UDP",
      "active": false
    }
  }
}
```
