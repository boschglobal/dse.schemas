---
title: "Schema: Stack"
linkTitle: "Stack"
---

(v0.0.1)

<h2 id="tocS_Stack">Stack</h2>

<a id="schemastack"></a>
<a id="schema_Stack"></a>
<a id="tocSstack"></a>
<a id="tocsstack"></a>

```yaml
kind: Stack
metadata:
  name: string
  labels:
    property1: string
    property2: string
  annotations:
    property1: string
    property2: string
spec:
  connection:
    timeout: string
    transport:
      redis:
        uri: string
        timeout: 0
  models:
    - name: string
      uid: 0
      model:
        name: string
        mcl:
          strategy: string
          models:
            - name: string
        metadata:
          property1: string
          property2: string
      channels:
        - name: string
          alias: string
          expectedModelCount: 0
          selectors:
            property1: string
            property2: string
          annotations:
            property1: string
            property2: string

```

A stack definition.

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|kind|string|true|Indicate the type of object.|
|metadata|object|false|Information relating to an object.|
|» name|string|false|The name of the object.|
|» labels|object|false|Identifying information used to identify objects within the system (e.g. giving a specific 'label' to an object).|
|»» **additionalProperties**|string|false|none|
|» annotations|object|false|Non identifying information (i.e. information specific to the object itself).|
|»» **additionalProperties**|string|false|none|
|spec|object|true|none|
|» connection|object|false|none|
|»» timeout|string|false|Model timeout for messages from the transport.|
|»» transport|object|false|none|

oneOf

|Name|Type|Required|Description|
|---|---|---|---|
|»»» *anonymous*|object|false|none|
|»»»» redis|[RedisConnection](#schemaredisconnection)|true|Redis connection.|

xor

|Name|Type|Required|Description|
|---|---|---|---|
|»»» *anonymous*|object|false|none|
|»»»» redispubsub|[RedisConnection](#schemaredisconnection)|true|Redis connection.|

xor

|Name|Type|Required|Description|
|---|---|---|---|
|»»» *anonymous*|object|false|none|
|»»»» mq|[MessageQueue](#schemamessagequeue)|true|Message Queue based connection.|

continued

|Name|Type|Required|Description|
|---|---|---|---|
|» models|[[ModelInstance](#schemamodelinstance)]|false|[A model instance object.]|

#### Enumerated Values

|Property|Value|
|---|---|
|kind|Stack|

<h2 id="tocS_ModelInstance">ModelInstance</h2>

<a id="schemamodelinstance"></a>
<a id="schema_ModelInstance"></a>
<a id="tocSmodelinstance"></a>
<a id="tocsmodelinstance"></a>

```yaml
name: string
uid: 0
model:
  name: string
  mcl:
    strategy: string
    models:
      - name: string
  metadata:
    property1: string
    property2: string
channels:
  - name: string
    alias: string
    expectedModelCount: 0
    selectors:
      property1: string
      property2: string
    annotations:
      property1: string
      property2: string

```

A model instance object.

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|name|string|true|none|
|uid|integer|true|none|
|model|object|true|none|
|» name|string|true|none|
|» mcl|object|false|none|
|»» strategy|string|true|none|
|»» models|[object]|true|A list of models belonging to this MCL.|
|»»» name|string|true|The name of the MCL model.|
|» metadata|object|false|Non identifying information (i.e. information specific to the object itself).|
|»» **additionalProperties**|string|false|none|
|channels|[object]|false|none|
|» name|string|false|The name of the channel, used when connecting this channel to the SimBus.|
|» alias|string|false|The alias of the channel, used when the channel name will be determined elsewhere.|
|» expectedModelCount|integer|false|Indicates how many models are expected to connect to this channel (used by SimBus only).|
|» selectors|object|false|Identifying information used to identify objects within the system (e.g. giving a specific 'label' to an object).|
|»» **additionalProperties**|string|false|none|
|» annotations|object|false|Non identifying information (i.e. information specific to the object itself).|
|»» **additionalProperties**|string|false|none|

<h2 id="tocS_RedisConnection">RedisConnection</h2>

<a id="schemaredisconnection"></a>
<a id="schema_RedisConnection"></a>
<a id="tocSredisconnection"></a>
<a id="tocsredisconnection"></a>

```yaml
uri: string
timeout: 0

```

Redis connection.

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|uri|string|false|none|
|timeout|integer|false|none|

<h2 id="tocS_MessageQueue">MessageQueue</h2>

<a id="schemamessagequeue"></a>
<a id="schema_MessageQueue"></a>
<a id="tocSmessagequeue"></a>
<a id="tocsmessagequeue"></a>

```yaml
uri: string

```

Message Queue based connection.

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|uri|string|false|none|

undefined
