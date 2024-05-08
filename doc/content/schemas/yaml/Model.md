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
    ? property1
    ? property2
spec:
  runtime:
    dynlib:
      - path: string
        os: string
        arch: string
        variant: string
        libs:
          - string
        annotations:
          ? property1
          ? property2
    executable:
      - os: string
        arch: string
        libs:
          - string
        annotations:
          ? property1
          ? property2
    gateway:
      annotations:
        ? property1
        ? property2
    mcl:
      - path: string
        os: string
        arch: string
        variant: string
        libs:
          - string
        annotations:
          ? property1
          ? property2
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

This schema object defines a Model kind. A Model kind is used to define a model which participates within a DSE based simulation.

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
|spec|[ModelSpec](#schemamodelspec)|true|none|

#### Enumerated Values

|Property|Value|
|---|---|
|kind|Model|

<h2 id="tocS_ModelSpec">ModelSpec</h2>

<a id="schemamodelspec"></a>
<a id="schema_ModelSpec"></a>
<a id="tocSmodelspec"></a>
<a id="tocsmodelspec"></a>

```yaml
runtime:
  dynlib:
    - path: string
      os: string
      arch: string
      variant: string
      libs:
        - string
      annotations:
        ? property1
        ? property2
  executable:
    - os: string
      arch: string
      libs:
        - string
      annotations:
        ? property1
        ? property2
  gateway:
    annotations:
      ? property1
      ? property2
  mcl:
    - path: string
      os: string
      arch: string
      variant: string
      libs:
        - string
      annotations:
        ? property1
        ? property2
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
|runtime|object|false|Selects (or defines) the kind of runtime that a particular model implements. In some cases several runtimes of a particular type may be defined according to operating system architecture.|
|» dynlib|[[LibrarySpec](#schemalibraryspec)]|false|Dynamic Library runtime specifications.|
|» executable|[[ExecutableSpec](#schemaexecutablespec)]|false|Executable runtime specifications.|
|» gateway|[GatewaySpec](#schemagatewayspec)|false|Defines a Gateway Model which represents a connection from a remote simulation system. The remote system loads a model which includes the ModelC Gateway functionality, that model is then able to connect to a DSE based simulation using the ModelC Gateway functionality.<br>The remote system may be a different type of simulation environment.|
|» mcl|[[LibrarySpec](#schemalibraryspec)]|false|Model Compatibility Library runtime specifications.|
|channels|[object]|false|A list of channels belonging to this model.|
|» name|string|false|The name of the channel, used when connecting this channel to the SimBus.|
|» alias|string|false|The alias of the channel, used when the channel name will be determined elsewhere.|
|» expectedModelCount|integer|false|Indicates how many models are expected to connect to this channel (used by SimBus only).|
|» selectors|object|false|Identifying information used to identify objects within the system (e.g. giving a specific 'label' to an object).|
|»» **additionalProperties**|string|false|none|
|» annotations|object|false|Non identifying information (i.e. information specific to the object itself).|
|»» **additionalProperties**|any|false|none|

<h2 id="tocS_LibrarySpec">LibrarySpec</h2>

<a id="schemalibraryspec"></a>
<a id="schema_LibrarySpec"></a>
<a id="tocSlibraryspec"></a>
<a id="tocslibraryspec"></a>

```yaml
path: string
os: string
arch: string
variant: string
libs:
  - string
annotations:
  ? property1
  ? property2

```

Defines a Model which is implemented as a dynamic library.
The model defined here will be loaded by an appropriate runtime executable, that executable provides all necessary library functions related to the DSE simulation environment. Addition libraries may be specified via the `libs` property.

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|path|string|true|The relative (to the model package) path to the runtime artifact.|
|os|string|false|Indicate the operating system of the runtime (e.g. linux, windows).|
|arch|string|false|Indicate the architecture of the runtime (e.g. amd64, w32)|
|variant|string|false|Indicate the architecture sub variant of the runtime (e.g. v7)|
|libs|[string]|false|A list of libraries on which the runtime is dependant.|
|annotations|object|false|Non identifying information (i.e. information specific to the object itself).|
|» **additionalProperties**|any|false|none|

<h2 id="tocS_GatewaySpec">GatewaySpec</h2>

<a id="schemagatewayspec"></a>
<a id="schema_GatewaySpec"></a>
<a id="tocSgatewayspec"></a>
<a id="tocsgatewayspec"></a>

```yaml
annotations:
  ? property1
  ? property2

```

Defines a Gateway Model which represents a connection from a remote simulation system. The remote system loads a model which includes the ModelC Gateway functionality, that model is then able to connect to a DSE based simulation using the ModelC Gateway functionality.
The remote system may be a different type of simulation environment.

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|annotations|[LibrarySpec/properties/annotations](#schemalibraryspec/properties/annotations)|false|Non identifying information (i.e. information specific to the object itself).|

<h2 id="tocS_ExecutableSpec">ExecutableSpec</h2>

<a id="schemaexecutablespec"></a>
<a id="schema_ExecutableSpec"></a>
<a id="tocSexecutablespec"></a>
<a id="tocsexecutablespec"></a>

```yaml
os: string
arch: string
libs:
  - string
annotations:
  ? property1
  ? property2

```

Defines a model implemented in an executable. The functions representing the model functionality will be taken directly from linked symbols in the executable file.

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|os|string|false|Indicate the operating system of the executable (e.g. linux, windows).|
|arch|string|false|Indicate the architecture of the executable (e.g. amd64, w32)|
|libs|[string]|false|A list of libraries on which the executable is dependant. The executable would load each of the listed libraries.|
|annotations|[LibrarySpec/properties/annotations](#schemalibraryspec/properties/annotations)|false|Non identifying information (i.e. information specific to the object itself).|

undefined

