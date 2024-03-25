---
title: "Schema: Network"
linkTitle: "Network"
---

(v1.0.0)

<h2 id="tocS_Network">Network</h2>

<a id="schemanetwork"></a>
<a id="schema_Network"></a>
<a id="tocSnetwork"></a>
<a id="tocsnetwork"></a>

```yaml
kind: Network
metadata:
  name: CAN1
  annotations:
    message_lib: examples/stub/data/message.so
    function_lib: examples/stub/data/function.so
spec:
  messages:
    - message: systemStatus
      annotations:
        struct_name: CAN1_systemStatus_t
        struct_size: 4
        frame_id: 496
        frame_length: 8
        cycle_time_ms: 10
      signals:
        - signal: Crc
          annotations:
            struct_member_name: crc
            struct_member_offset: 0
            struct_member_primitive_type: uint8_t
        - signal: Alive
          annotations:
            struct_member_name: alive
            struct_member_offset: 1
            struct_member_primitive_type: uint8
        - signal: Temperature
          annotations:
            struct_member_name: temperature
            struct_member_offset: 2
            struct_member_primitive_type: int16_t
      functions:
        encode:
          - function: counter_inc_uint8
            annotations:
              position: 1
          - function: crc_generate
            annotations:
              position: 0
        decode:
          - function: crc_validate
            annotations:
              position: 0

```

A Network definition.

### Supported annotations:
|Annotation|Description|
|---|---|
|`message_lib`|Relative path of the shared library containing the Network Message symbols.|
|`function_lib`|Relative path of the shared library containing Network Function symbols.|
|`node_id`|The identifier of the Node used to indicate the sender of a network message. Typically specified in a `mimeTYPE` for the Network Signal, however a value may also be specified here.|
|`interface_id`|The identifier of the Interface of the Node used to send a network message. Typically specified in a `mimeTYPE` for the Network Signal, however a value may also be specified here.|
|`bus_id`|The identifier of the Bus connected to the Interface of the Node. Typically specified in a `mimeTYPE` for the Network Signal, however a value may also be specified here.|

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|kind|string|true|none|
|metadata|object|false|Information relating to an object.|
|» name|string|false|The name of the object.|
|» labels|object|false|Identifying information used to identify objects within the system (e.g. giving a specific 'label' to an object).|
|»» **additionalProperties**|string|false|none|
|» annotations|object|false|Non identifying information (i.e. information specific to the object itself).|
|»» **additionalProperties**|string|false|none|
|spec|[NetworkSpec](#schemanetworkspec)|true|none|

#### Enumerated Values

|Property|Value|
|---|---|
|kind|Network|

<h2 id="tocS_NetworkSpec">NetworkSpec</h2>

<a id="schemanetworkspec"></a>
<a id="schema_NetworkSpec"></a>
<a id="tocSnetworkspec"></a>
<a id="tocsnetworkspec"></a>

```yaml
messages:
  - message: systemStatus
    annotations:
      struct_name: CAN1_systemStatus_t
      struct_size: 4
      frame_id: 496
      frame_length: 8
      cycle_time_ms: 10
    signals:
      - signal: Crc
        annotations:
          struct_member_name: crc
          struct_member_offset: 0
          struct_member_primitive_type: uint8_t
    functions:
      encode:
        - function: crc_generate
          annotations:
            position: 0
      decode:
        - function: crc_validate
          annotations:
            position: 0

```

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|messages|[[NetworkMessage](#schemanetworkmessage)]|true|A list of messages belonging to this Network.|

<h2 id="tocS_NetworkMessage">NetworkMessage</h2>

<a id="schemanetworkmessage"></a>
<a id="schema_NetworkMessage"></a>
<a id="tocSnetworkmessage"></a>
<a id="tocsnetworkmessage"></a>

```yaml
message: systemStatus
annotations:
  struct_name: CAN1_systemStatus_t
  struct_size: 4
  frame_id: 496
  frame_length: 8
  cycle_time_ms: 10
signals:
  - signal: Crc
    annotations:
      struct_member_name: crc
      struct_member_offset: 0
      struct_member_primitive_type: uint8_t
functions:
  encode:
    - function: crc_generate
      annotations:
        position: 0
  decode:
    - function: crc_validate
      annotations:
        position: 0

```

A Network message definition.

### Supported annotations:
|Annotation|Description|
|---|---|
|`struct_name`|Name of the typedef/struct representing the message.|
|`struct_size`|Size of the message struct (in bytes).|
|`frame_id`|The frame id of the message when encoded to a bus transport (e.g. CAN Frame ID).|
|`frame_length`|The length of the message when encoded (in bytes).|
|`cycle_time_ms`|Message will be sent according to the specified schedule (milliseconds).|

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|message|string|true|The name of the message.|
|annotations|object|false|Non identifying information (i.e. information specific to the object itself).|
|» **additionalProperties**|string|false|none|
|signals|[[NetworkSignal](#schemanetworksignal)]|false|A list of signals represented in this message.|
|functions|[NetworkFunctions](#schemanetworkfunctions)|false|Message functions to be applied to this message.|

<h2 id="tocS_NetworkSignal">NetworkSignal</h2>

<a id="schemanetworksignal"></a>
<a id="schema_NetworkSignal"></a>
<a id="tocSnetworksignal"></a>
<a id="tocsnetworksignal"></a>

```yaml
signal: Temperature
annotations:
  struct_member_name: temperature
  struct_member_offset: 2
  struct_member_primitive_type: int16_t

```

A Network signal definition.

### Supported annotations:
|Annotation|Description|
|---|---|
|`init_value`|The signal is initialised to this value. The value will be interpreted according to the `struct_member_primitive_type` annotation.|
|`struct_member_name`|Name of the struct member which represents this signal.|
|`struct_member_offset`|Offset of the member in the struct (in bytes).|
|`struct_member_primitive_type`|The primitive type of the member (select from int8_t, int16_t, int32_t, int64_t, uint8_t, uint16_t, uint32_t, uint64_t, float or double).|

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|signal|string|true|The name of the signal.|
|annotations|[NetworkMessage/properties/annotations](#schemanetworkmessage/properties/annotations)|false|Non identifying information (i.e. information specific to the object itself).|

<h2 id="tocS_NetworkFunctions">NetworkFunctions</h2>

<a id="schemanetworkfunctions"></a>
<a id="schema_NetworkFunctions"></a>
<a id="tocSnetworkfunctions"></a>
<a id="tocsnetworkfunctions"></a>

```yaml
encode:
  - &a1
    function: crc_generate
    annotations:
      position: 0
decode:
  - *a1

```

Message functions to be applied to this message.

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|encode|[[NetworkFunction](#schemanetworkfunction)]|false|Message functions applied to the encode processing path (i.e. from Signal to Network interface). Functions are implicitly applied in the order of definition.|
|decode|[[NetworkFunction](#schemanetworkfunction)]|false|Message functions applied to the decode processing path (i.e. from Network to Signal interface). Functions are implicitly applied in the order of definition.|

<h2 id="tocS_NetworkFunction">NetworkFunction</h2>

<a id="schemanetworkfunction"></a>
<a id="schema_NetworkFunction"></a>
<a id="tocSnetworkfunction"></a>
<a id="tocsnetworkfunction"></a>

```yaml
function: crc_generate
annotations:
  position: 0

```

A Network Function definition.

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|function|string|true|The name of the function (i.e. the name of the symbol _in_ the Network Function shared library).|
|annotations|[NetworkMessage/properties/annotations](#schemanetworkmessage/properties/annotations)|false|Non identifying information (i.e. information specific to the object itself).|

undefined

