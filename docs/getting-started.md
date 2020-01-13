# Getting Started

## Overview

Canyan Rating Engine is though from day one as a highly scalable, cloud-native, 
real-time rating service. To be highly scalable, Canyan is composed as 
microservice architecture with three loosely coupled main services created for
lightweight container deployment:

* Agent
* API
* Engine

The following schema describes the interaction between these components, 
the message bus and the database.

<div class="mermaid">
graph LR
    C(Client) -->|Internet| AGT(Agent REST API)
    RMQ[RabbitMQ] --> AGT
    API(API) --> RMQ
    API --> MDB[MongoDB]
    W(Worker) --> API
    RMQ --> W
    W --> RMQ
    AGT --> RMQ
    AGT -->|Internet| C
    RMQ --> API
</div>

Now, let's go in deep with each component...


## Agent

The Agent is the Interpreter between the user communication/IoT service and 
Canyan Rating Engine. It is a REST API service with simple endpoints to handle
authorization requests and transaction recordings. It also supports callbacks
for example for ending transactions in case an account has exhausted it's 
balance.


## API

The API component is the interface between the components and the database. 
It is used by every component and it is interfaced with the message bus also.
Obviously, it is also used for CRUD operations on the models being called 
from the client's IS or UI.

<div class="mermaid">
graph LR
    C(Client) -->|Internet| API
    UI(UI) -->|Internet| API
    API --> MDB[MongoDB]
</div>

## Engine

The Engine gets the tasks via message bus and uses the API to gather further
information needed for the calculations. 
