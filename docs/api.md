# Canyan Rating API

## Carrier
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 

### Get all Carriers
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 
#### Request headers
```Content-Type	application/json```

#### Request parameters
| Parameter | type | description |
|-|-|-|
|`_allCarriersMeta.page`| *int* | page number, starting from zero |
|`_allCarriersMeta.perPage` |	*int*	| number of items returned per page |
|`_allCarriersMeta.sortField`	| *str*	| field used to sort the returned items, defaults to *id* |
|`_allCarriersMeta.sortOrder`	| *str*	| asc or desc, defaults to *asc* |

#### Response
`allCarriers.id`	*objectid*	Identifier of the carrier

`allCarriers.tenant`	*string*	The associated tenant of the carrier

`allCarriers.carrier_tag`	*string*	The tag of the carrier

`allCarriers.host`	*string*	The carriers's host (hostname or IP)

`allCarriers.port`	*int*	The communication endpoint port

`allCarriers.protocol`	*CarrierProtocol*	TCP or UDP protocol

`allCarriers.active`	*int*	Is this carrier enabled?

`meta.count`	*int*	Results count

#### Example
```bash
$ curl "https://api.canyan.io/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <your-token-here>" \
  --data @- <<EOF
{"query": "{
    allCarriers {
      id
      tenant
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

Response:
```
HTTP/1.1 200 OK
Content-Type: application/json
{
  "data": {
    "allCarriers": [
      {
        "id": "40419d91-23af-43db-a54a-3744d4f8fb8f",
        "tenant": "alex",
        "carrier_tag": "carrier1",
        "host": "carrier1.alex.com",
        "port": 5060,
        "protocol": "TCP",
        "active": true
      },
      {
        "id": "6dd0fdee-000d-43ce-9678-821a3ef5f97f",
        "tenant": "alex",
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

### Get specific Carrier details
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 
### Create a new Carrier
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 
### Update a Carrier
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 
### Delete a Carrier
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 

