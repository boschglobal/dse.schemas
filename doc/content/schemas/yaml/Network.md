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
|»» **additionalProperties**|any|false|none|
|spec|[NetworkSpec](#schemanetworkspec)|true|Specification for a Network.|

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
{}

```

Specification for a Network.

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|messages|[[NetworkMessage](#schemanetworkmessage)]|false|A list of messages belonging to this Network.|
|pdus|[object]|false|A list of PDUs belonging to this Network..|
|» pdu|string|false|The name of the PDU.|
|» id|integer|true|Identifier for the PDU.|
|» length|integer|true|Length of the PDU in bytes.|
|» annotations|object|false|Non identifying information (i.e. information specific to the object itself).|
|»» **additionalProperties**|any|false|none|
|» container|integer|false|Optional container identifier indicating this PDU is emitted within a multiplexor PDU (M-PDU).|
|» functions|object|false|Lua-based script/functions to be applied in order. Each entry contains a Lua script block which is loaded into the Lua runtime.|
|»» encode|[object]|false|Lua script/functions applied during the encode path.|
|»»» lua|string|true|Inline Lua script. Multi-line strings supported.|
|»» decode|[[NetworkSpec/properties/pdus/items/properties/functions/properties/encode/items](#schemanetworkspec/properties/pdus/items/properties/functions/properties/encode/items)]|false|Lua script/functions applied during the decode path.|
|» metadata|any|false|Transport metadata for a PDU.|

oneOf

|Name|Type|Required|Description|
|---|---|---|---|
|»» *anonymous*|object|false|none|
|»»» can|object|true|none|
|»»»» message_format|integer|false|none|
|»»»» frame_type|integer|false|none|
|»»»» interface_id|integer|false|CAN interface ID of the interface sending this PDU.|
|»»»» network_id|integer|false|CAN network ID carrying this PDU.|

xor

|Name|Type|Required|Description|
|---|---|---|---|
|»» *anonymous*|object|false|none|
|»»» flexray|object|true|none|
|»»»» slot_id|integer|false|none|
|»»»» payload_length|integer|false|none|
|»»»» cycle_repetition|integer|false|none|
|»»»» base_cycle|integer|false|none|
|»»»» direction|integer|false|none|
|»»»» channel|integer|false|none|
|»»»» transmit_mode|integer|false|none|
|»»»» inhibit_null|boolean|false|none|

xor

|Name|Type|Required|Description|
|---|---|---|---|
|»» *anonymous*|object|false|none|
|»»» ip|object|true|none|
|»»»» eth_dst_mac|integer|false|Destination MAC (lower 48-bits used).|
|»»»» eth_src_mac|integer|false|Source MAC (lower 48-bits used).|
|»»»» eth_ethertype|integer|false|none|
|»»»» eth_tci_pcp|integer|false|none|
|»»»» eth_tci_dei|integer|false|none|
|»»»» eth_tci_vid|integer|false|none|
|»»»» ip_addr|any|false|IP address (IPv4 or IPv6).|

oneOf

|Name|Type|Required|Description|
|---|---|---|---|
|»»»»» *anonymous*|object|false|none|
|»»»»»» src_addr|integer|true|none|
|»»»»»» dst_addr|integer|true|none|

xor

|Name|Type|Required|Description|
|---|---|---|---|
|»»»»» *anonymous*|object|false|none|
|»»»»»» src_addr|object|true|none|
|»»»»»»» v0|integer|false|none|
|»»»»»»» v1|integer|false|none|
|»»»»»»» v2|integer|false|none|
|»»»»»»» v3|integer|false|none|
|»»»»»»» v4|integer|false|none|
|»»»»»»» v5|integer|false|none|
|»»»»»»» v6|integer|false|none|
|»»»»»»» v7|integer|false|none|
|»»»»»» dst_addr|[NetworkSpec/properties/pdus/items/properties/metadata/oneOf/2/properties/ip/properties/ip_addr/oneOf/1/properties/src_addr](#schemanetworkspec/properties/pdus/items/properties/metadata/oneof/2/properties/ip/properties/ip_addr/oneof/1/properties/src_addr)|true|none|

continued

|Name|Type|Required|Description|
|---|---|---|---|
|»»»» ip_protocol|integer|false|0=None, 6=TCP, 17=UDP|
|»»»» ip_src_port|integer|false|none|
|»»»» ip_dst_port|integer|false|none|
|»»»» adapter|any|false|Socket adapter metadata (DoIP or SOME/IP).|

oneOf

|Name|Type|Required|Description|
|---|---|---|---|
|»»»»» *anonymous*|object|false|none|
|»»»»»» protocol_version|integer|true|none|
|»»»»»» payload_type|integer|true|none|

xor

|Name|Type|Required|Description|
|---|---|---|---|
|»»»»» *anonymous*|object|false|none|
|»»»»»» message_id|integer|true|none|
|»»»»»» length|integer|true|none|
|»»»»»» request_id|integer|true|none|
|»»»»»» protocol_version|integer|true|none|
|»»»»»» interface_version|integer|true|none|
|»»»»»» message_type|integer|true|none|
|»»»»»» return_code|integer|true|none|

xor

|Name|Type|Required|Description|
|---|---|---|---|
|»» *anonymous*|object|false|none|
|»»» struct|object|true|none|
|»»»» type_name|string|false|none|
|»»»» var_name|string|false|none|
|»»»» encoding|string|false|none|
|»»»» attribute_aligned|integer|false|none|
|»»»» attribute_packed|boolean|false|none|
|»»»» platform_arch|string|false|none|
|»»»» platform_os|string|false|none|
|»»»» platform_abi|string|false|none|

continued

|Name|Type|Required|Description|
|---|---|---|---|
|» signals|[oneOf]|true|Defines the layout and content of the PDU. Each entry is one of:<br>- a multiplexor definition (`multiplexor:`) using byte-based encoding<br>- a nested PDU container area (`pdu:`) using byte-based encoding<br>- a scalar signal (`signal:`) using bit-based `encoding`|

oneOf

|Name|Type|Required|Description|
|---|---|---|---|
|»» *anonymous*|object|false|Defines a multiplexor field using byte-based encoding. The `id` of the contained PDU is written into this field.|
|»»» multiplexor|object|true|Byte-based encoding, used for multiplexor and nested PDU container entries.|
|»»»» start|integer|true|Start offset in bytes.|
|»»»» length|integer|true|Length in bytes.|

xor

|Name|Type|Required|Description|
|---|---|---|---|
|»» *anonymous*|object|false|Defines a nested PDU container area using byte-based encoding. The contained PDU is copied into this field.|
|»»» pdu|[NetworkSpec/properties/pdus/items/properties/signals/items/oneOf/0/properties/multiplexor](#schemanetworkspec/properties/pdus/items/properties/signals/items/oneof/0/properties/multiplexor)|true|Byte-based encoding, used for multiplexor and nested PDU container entries.|

xor

|Name|Type|Required|Description|
|---|---|---|---|
|»» *anonymous*|object|false|Defines a scalar signal and its associated encoding.|
|»»» signal|string|true|The name of the scalar signal.|
|»»» encoding|object|false|Bit-based encoding for scalar signals, with optional scaling and Lua hooks.|
|»»»» factor|number|false|Scaling factor applied during encode/decode.|
|»»»» offset|number|false|Offset applied during encode/decode.|
|»»»» min|number|false|Optional minimum value constraint (of the physical signal value). Causes truncation of the value.|
|»»»» max|number|false|Optional maximum value constraint. (of the physical signal value). Causes truncation of the value.|
|»»»» start|integer|true|Bit start position for the encoded signal value in the PDU.|
|»»»» length|integer|true|Bit length for the encoded signal value in the PDU.|
|»»» functions|[NetworkSpec/properties/pdus/items/properties/functions](#schemanetworkspec/properties/pdus/items/properties/functions)|false|Lua-based script/functions to be applied in order. Each entry contains a Lua script block which is loaded into the Lua runtime.|
|»»» annotations|[NetworkSpec/properties/pdus/items/properties/annotations](#schemanetworkspec/properties/pdus/items/properties/annotations)|false|Non identifying information (i.e. information specific to the object itself).|

continued

|Name|Type|Required|Description|
|---|---|---|---|
|metadata|[NetworkMetadata](#schemanetworkmetadata)|false|Network-level metadata and configuration objects.|

anyOf

|Name|Type|Required|Description|
|---|---|---|---|
|*anonymous*|object|false|none|

or

|Name|Type|Required|Description|
|---|---|---|---|
|*anonymous*|object|false|none|

#### Enumerated Values

|Property|Value|
|---|---|
|message_format|Base|
|message_format|Extended|
|message_format|FdBase|
|message_format|FdExtended|
|frame_type|Data|
|frame_type|Remote|
|frame_type|Error|
|frame_type|Overload|
|direction|Rx|
|direction|Tx|
|channel|A|
|channel|B|
|channel|AB|
|transmit_mode|Continuous|
|transmit_mode|SingleShot|
|ip_protocol|0|
|ip_protocol|6|
|ip_protocol|17|

<h2 id="tocS_NetworkMetadata">NetworkMetadata</h2>

<a id="schemanetworkmetadata"></a>
<a id="schema_NetworkMetadata"></a>
<a id="tocSnetworkmetadata"></a>
<a id="tocsnetworkmetadata"></a>

```yaml
flexray:
  vcn:
    - ecu_id: 0
      cc_id: 0
      swc_id: 0
  initial_poc_state_cha: 0
  initial_poc_state_chb: 0
  inhibit_null_frames: true
  macrotick_per_cycle: 0
  microtick_per_cycle: 0
  network_idle_start: 0
  static_slot_length: 0
  static_slot_count: 0
  minislot_length: 0
  minislot_count: 0
  static_slot_payload_length: 0
  bit_rate: BR10Mbps
  channel_enable: A
  wakeup_channel_select: 0
  single_slot_enabled: true
  bus_model_mode: Pop
  node_name: string

```

Network-level metadata and configuration objects.

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|flexray|object|true|none|
|» vcn|[object]|false|none|
|»» ecu_id|integer|false|none|
|»» cc_id|integer|false|none|
|»» swc_id|integer|false|none|
|» initial_poc_state_cha|integer|false|none|
|» initial_poc_state_chb|[NetworkMetadata/oneOf/0/properties/flexray/properties/initial_poc_state_cha](#schemanetworkmetadata/oneof/0/properties/flexray/properties/initial_poc_state_cha)|false|none|
|» inhibit_null_frames|boolean|false|none|
|» macrotick_per_cycle|integer|false|none|
|» microtick_per_cycle|integer|false|none|
|» network_idle_start|integer|false|none|
|» static_slot_length|integer|false|none|
|» static_slot_count|integer|false|none|
|» minislot_length|integer|false|none|
|» minislot_count|integer|false|none|
|» static_slot_payload_length|integer|false|none|
|» bit_rate|integer|false|none|
|» channel_enable|integer|false|none|
|» wakeup_channel_select|integer|false|none|
|» single_slot_enabled|boolean|false|none|
|» bus_model_mode|integer|false|none|
|» node_name|string|false|none|

#### Enumerated Values

|Property|Value|
|---|---|
|initial_poc_state_cha|0|
|initial_poc_state_cha|1|
|initial_poc_state_cha|2|
|initial_poc_state_cha|3|
|initial_poc_state_cha|4|
|initial_poc_state_cha|5|
|initial_poc_state_cha|6|
|initial_poc_state_cha|7|
|initial_poc_state_cha|8|
|initial_poc_state_cha|9|
|bit_rate|BR10Mbps|
|bit_rate|BR5Mbps|
|bit_rate|BR2_5Mbps|
|channel_enable|A|
|channel_enable|B|
|channel_enable|AB|
|bus_model_mode|Pop|

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
|» **additionalProperties**|any|false|none|
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

