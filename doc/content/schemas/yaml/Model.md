---
title: "Schema: Model"
linkTitle: "Model"
---

(v0.0.1)

<h2 id="tocS_Model">Model</h2>

<a id="schemamodel"></a>
<a id="schema_Model"></a>
<a id="tocSmodel"></a>
<a id="tocsmodel"></a>

```yaml
kind: Model
metadata:
  name: string
  labels:
    property1: string
    property2: string
  annotations:
    property1: string
    property2: string
spec:
  runtime:
    executable:
      - path: string
        os: string
        arch: string
        variant: string
        libs:
          - string
        annotations:
          property1: string
          property2: string
    dynlib:
      - path: string
        os: string
        arch: string
        variant: string
        libs:
          - string
        annotations:
          property1: string
          property2: string
    container:
      - path: string
        os: string
        arch: string
        variant: string
        libs:
          - string
        annotations:
          property1: string
          property2: string
    mcl:
      - path: string
        os: string
        arch: string
        variant: string
        libs:
          - string
        annotations:
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

A model definition.

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
|spec|object|true|none|
|» runtime|object|false|Collection of runtimes made available by this model (package).|
|»» executable|[[RuntimeSpec](#schemaruntimespec)]|false|Executable runtime specifications.|
|»» dynlib|[[RuntimeSpec](#schemaruntimespec)]|false|Dynamic Library runtime specifications.|
|»» container|[[RuntimeSpec](#schemaruntimespec)]|false|Container runtime specifications.|
|»» mcl|[[RuntimeSpec](#schemaruntimespec)]|false|Model Compatibility Library runtime specifications.|
|» channels|[object]|false|A list of channels belonging to this model.|
|»» name|string|false|The name of the channel, used when connecting this channel to the SimBus.|
|»» alias|string|false|The alias of the channel, used when the channel name will be determined elsewhere.|
|»» expectedModelCount|integer|false|Indicates how many models are expected to connect to this channel (used by SimBus only).|
|»» selectors|object|false|Identifying information used to identify objects within the system (e.g. giving a specific 'label' to an object).|
|»»» **additionalProperties**|string|false|none|
|»» annotations|object|false|Non identifying information (i.e. information specific to the object itself).|
|»»» **additionalProperties**|string|false|none|

#### Enumerated Values

|Property|Value|
|---|---|
|kind|Model|

<h2 id="tocS_RuntimeSpec">RuntimeSpec</h2>

<a id="schemaruntimespec"></a>
<a id="schema_RuntimeSpec"></a>
<a id="tocSruntimespec"></a>
<a id="tocsruntimespec"></a>

```yaml
path: string
os: string
arch: string
variant: string
libs:
  - string
annotations:
  property1: string
  property2: string

```

A runtime definition.

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|path|string|true|The relative (to the model package) path to the runtime artifact.|
|os|string|false|Indicate the operating system of the runtime (e.g. linux, windows).|
|arch|string|false|Indicate the architecture of the runtime (e.g. amd64, w32)|
|variant|string|false|Indicate the architecture sub variant of the runtime (e.g. v7)|
|libs|[string]|false|A list of libraries on which the runtime is dependant.|
|annotations|object|false|Non identifying information (i.e. information specific to the object itself).|
|» **additionalProperties**|string|false|none|

undefined

