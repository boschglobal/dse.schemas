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
  name: default
  annotations:
    simulation:
      stepsize: 0.0005
      endtime: 0.2
spec:
  connection:
    transport:
      redis:
        timeout: 60
        uri: redis://localhost:6379
  models:
    - name: simbus
      uid: 0
      model:
        name: simbus
      channels:
        - expectedModelCount: 1
          name: physical
    - name: input
      uid: 1
      model:
        name: dse.modelc.csv
      runtime:
        env:
          CSV_FILE: model/input/data/input.csv
        paths:
          - model/input/data
      channels:
        - alias: signal_channel
          name: physical
          selectors:
            channel: signal_vector
            model: input

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
|»» **additionalProperties**|any|false|none|
|spec|[StackSpec](#schemastackspec)|true|none|

#### Enumerated Values

|Property|Value|
|---|---|
|kind|Stack|

<h2 id="tocS_StackSpec">StackSpec</h2>

<a id="schemastackspec"></a>
<a id="schema_StackSpec"></a>
<a id="tocSstackspec"></a>
<a id="tocsstackspec"></a>

```yaml
connection:
  timeout: string
  transport:
    redis:
      uri: string
      timeout: 0
runtime:
  env:
    property1: string
    property2: string
  stacked: true
  sequential: true
models:
  - name: string
    uid: 0
    annotations:
      ? property1
      ? property2
    model:
      name: string
    runtime:
      env:
        property1: string
        property2: string
      files:
        - string
      paths:
        - string
      x32: true
      i386: true
      external: true
      mcl: string
    channels:
      - name: string
        alias: string
        expectedModelCount: 0
        selectors:
          property1: string
          property2: string
        annotations:
          ? property1
          ? property2

```

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|connection|object|false|none|
|» timeout|string|false|Model timeout for messages from the transport.|
|» transport|object|false|none|

oneOf

|Name|Type|Required|Description|
|---|---|---|---|
|»» *anonymous*|object|false|none|
|»»» redis|[RedisConnection](#schemaredisconnection)|true|Redis connection.|

xor

|Name|Type|Required|Description|
|---|---|---|---|
|»» *anonymous*|object|false|none|
|»»» redispubsub|[RedisConnection](#schemaredisconnection)|true|Redis connection.|

xor

|Name|Type|Required|Description|
|---|---|---|---|
|»» *anonymous*|object|false|none|
|»»» mq|[MessageQueue](#schemamessagequeue)|true|Message Queue based connection.|

continued

|Name|Type|Required|Description|
|---|---|---|---|
|runtime|[StackRuntime](#schemastackruntime)|false|Runtime properties of a Stack.|
|models|[[ModelInstance](#schemamodelinstance)]|false|[A model instance object.]|

<h2 id="tocS_ModelInstance">ModelInstance</h2>

<a id="schemamodelinstance"></a>
<a id="schema_ModelInstance"></a>
<a id="tocSmodelinstance"></a>
<a id="tocsmodelinstance"></a>

```yaml
name: string
uid: 0
annotations:
  ? property1
  ? property2
model:
  name: string
runtime:
  env:
    property1: string
    property2: string
  files:
    - string
  paths:
    - string
  x32: true
  i386: true
  external: true
  mcl: string
channels:
  - name: string
    alias: string
    expectedModelCount: 0
    selectors:
      property1: string
      property2: string
    annotations:
      ? property1
      ? property2

```

A model instance object.

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|name|string|true|none|
|uid|integer|true|none|
|annotations|object|false|Non identifying information (i.e. information specific to the object itself).|
|» **additionalProperties**|any|false|none|
|model|object|false|none|
|» name|string|true|none|
|runtime|[ModelInstanceRuntime](#schemamodelinstanceruntime)|false|Runtime properties of a Model Instance.|
|channels|[object]|false|none|
|» name|string|false|The name of the channel, used when connecting this channel to the SimBus.|
|» alias|string|false|The alias of the channel, used when the channel name will be determined elsewhere.|
|» expectedModelCount|integer|false|Indicates how many models are expected to connect to this channel (used by SimBus only).|
|» selectors|object|false|Identifying information used to identify objects within the system (e.g. giving a specific 'label' to an object).|
|»» **additionalProperties**|string|false|none|
|» annotations|object|false|Non identifying information (i.e. information specific to the object itself).|
|»» **additionalProperties**|any|false|none|

<h2 id="tocS_StackRuntime">StackRuntime</h2>

<a id="schemastackruntime"></a>
<a id="schema_StackRuntime"></a>
<a id="tocSstackruntime"></a>
<a id="tocsstackruntime"></a>

```yaml
env:
  property1: string
  property2: string
stacked: true
sequential: true

```

Runtime properties of a Stack.

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|env|object|false|Environment variables.|
|» **additionalProperties**|string|false|none|
|stacked|boolean|false|Run all Models (of this stack) in a single instance of ModelC.|
|sequential|boolean|false|Run the Models in this Stack as a Sequential Co-Simulation. All Models run in a single instance of ModelC (i.e. setting `stacked` is implicitly selected).|

<h2 id="tocS_ModelInstanceRuntime">ModelInstanceRuntime</h2>

<a id="schemamodelinstanceruntime"></a>
<a id="schema_ModelInstanceRuntime"></a>
<a id="tocSmodelinstanceruntime"></a>
<a id="tocsmodelinstanceruntime"></a>

```yaml
env:
  property1: string
  property2: string
files:
  - string
paths:
  - string
x32: true
i386: true
external: true
mcl: string

```

Runtime properties of a Model Instance.

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|env|object|false|Environment variables.|
|» **additionalProperties**|string|false|none|
|files|[string]|false|Additional file arguments passed to ModelC.|
|paths|[string]|false|Paths to scan for additional (YAML) files, subsequently passed as arguments ModelC.|
|x32|boolean|false|Run Model with 32bit ModelC executable (x32 abi).|
|i386|boolean|false|Run Model with 32bit ModelC executable (i386 abi).|
|external|boolean|false|This model is external to the operated simulation (e.g. a Gateway).|
|mcl|string|false|This model is loaded and operated by the named MCL. The named MCL is provided by the ModelC (i.e. built-in).|

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

