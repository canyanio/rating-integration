# Getting Started

## Overview

Canyan Rating Engine is though from day one as a highly scalable, cloud-native, 
real-time rating service. To be scalable, Canyan is composed as 
microservice architecture with three loosely coupled main services created for
lightweight container deployment:

* Agent
* API
* Engine

The following schema describes the interaction between these components,
the message bus and the database.

<div class="mermaid">
graph LR
    C(Client) -->|HTTP| AGT(Agent REST API)
    RMQ[RabbitMQ] --> AGT
    API(API) --> RMQ
    API --> MDB[MongoDB]
    W(Worker) --> API
    RMQ --> W
    W --> RMQ
    AGT --> RMQ
    AGT -->|HTTP| C
    RMQ --> API
</div>

Now, let's describe each component in more detail.


## Agent

The Agent is the Interpreter between the user communication/IoT service and 
Canyan Rating Engine. It is a REST API service with simple endpoints to handle
authorization requests and transaction recordings. It also supports callbacks
for example for ending transactions in case an account has exhausted it's 
balance.


## API

The API component is the interface between the other components and the database. 
It is used by every component and it is also interfaced with the message bus.
Obviously, it is also used for CRUD operations on the models being called 
from the client's IS or UI.

<div class="mermaid">
graph LR
    C(Client) -->|HTTP| API
    UI(UI) -->|HTTP| API
    API --> MDB[MongoDB]
</div>

## Engine

The Engine fetches it's computational tasks via message bus and uses the API to gather further
information needed for the calculations. Once the calculation is done the Engine responds via bus
to the component that requested the task.
