---
title: "Schema: Manifest"
linkTitle: "Manifest"
---

(v0.0.1)

<h2 id="tocS_Manifest">Manifest</h2>

<a id="schemamanifest"></a>
<a id="schema_Manifest"></a>
<a id="tocSmanifest"></a>
<a id="tocsmanifest"></a>

```yaml
kind: Manifest
metadata:
  name: string
  labels:
    property1: string
    property2: string
  annotations:
    property1: string
    property2: string
spec:
  repos:
    - name: string
      repo: string
      path: string
      registry: string
      user: string
      token: string
  tools:
    - name: string
      version: string
      repo: string
      arch:
        - string
      schema: string
  models:
    - name: string
      version: string
      repo: string
      arch: string
      schema: string
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
  simulations:
    - name: string
      parameters:
        transport: redispubsub
        environment:
          property1: string
          property2: string
      files:
        - name: string
          uri: string
          repo: string
          processing: string
          generate: string
          modelc: true
      models:
        - name: string
          model: string
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
          files:
            - name: string
              uri: string
              repo: string
              processing: string
              generate: string
              modelc: true
  documentation:
    - name: string
      uri: string
      repo: string
      processing: string
      generate: string
      modelc: true

```

This schema object defines a Manifest kind. A Manifest kind is used to describe a compositional simulation in terms of Tools, Models, Configuration and other Files. The manifest can then be used to generate the simulation system.

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
|spec|[ManifestSpec](#schemamanifestspec)|true|none|

#### Enumerated Values

|Property|Value|
|---|---|
|kind|Manifest|

<h2 id="tocS_ManifestSpec">ManifestSpec</h2>

<a id="schemamanifestspec"></a>
<a id="schema_ManifestSpec"></a>
<a id="tocSmanifestspec"></a>
<a id="tocsmanifestspec"></a>

```yaml
repos:
  - name: string
    repo: string
    path: string
    registry: string
    user: string
    token: string
tools:
  - name: string
    version: string
    repo: string
    arch:
      - string
    schema: string
models:
  - name: string
    version: string
    repo: string
    arch: string
    schema: string
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
simulations:
  - name: string
    parameters:
      transport: redispubsub
      environment:
        property1: string
        property2: string
    files:
      - name: string
        uri: string
        repo: string
        processing: string
        generate: string
        modelc: true
    models:
      - name: string
        model: string
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
        files:
          - name: string
            uri: string
            repo: string
            processing: string
            generate: string
            modelc: true
documentation:
  - name: string
    uri: string
    repo: string
    processing: string
    generate: string
    modelc: true

```

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|repos|[[Repo](#schemarepo)]|true|List of repositories where artifacts used by this simulation may be located.|
|tools|[[Tool](#schematool)]|true|List of tools used by this simulation.|
|models|[[ModelDefinition](#schemamodeldefinition)]|true|List of model libraries used by this simulation.|
|simulations|[[Simulation](#schemasimulation)]|true|List of individual simulations which comprise this compositional simulation.|
|documentation|[[File](#schemafile)]|false|List of documentation files supporting this simulation.|

<h2 id="tocS_Repo">Repo</h2>

<a id="schemarepo"></a>
<a id="schema_Repo"></a>
<a id="tocSrepo"></a>
<a id="tocsrepo"></a>

```yaml
name: string
repo: string
path: string
registry: string
user: string
token: string

```

Define a repository where artifacts might be located. When a repository is referenced by a Tool, Model or File, that object will have the repository properties available as Task Variables which may be used to define a custom URI schema.

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|name|string|true|Name of the repository definition.|
|repo|string|false|Repository URI (e.g. as used by the `curl` command).|
|path|string|false|Repository path to the root location of artifacts.|
|registry|string|false|Registry name/path as used by docker.|
|user|string|true|User for authentication with the repository.|
|token|string|true|Token for authentication with the repository.|

<h2 id="tocS_Tool">Tool</h2>

<a id="schematool"></a>
<a id="schema_Tool"></a>
<a id="tocStool"></a>
<a id="tocstool"></a>

```yaml
name: string
version: string
repo: string
arch:
  - string
schema: string

```

Define a tool which will be used by the simulation.

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|name|string|true|Name of the tool.|
|version|string|true|Version of the tool.|
|repo|string|false|The name of the repo where this tool can be downloaded from.|
|arch|[string]|false|Architectures of the tool that should be downloaded.|
|schema|string|false|Define the URI schema for the tool.|

<h2 id="tocS_ModelDefinition">ModelDefinition</h2>

<a id="schemamodeldefinition"></a>
<a id="schema_ModelDefinition"></a>
<a id="tocSmodeldefinition"></a>
<a id="tocsmodeldefinition"></a>

```yaml
name: string
version: string
repo: string
arch: string
schema: string
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

Define a model library which will be used by the simulation. A model library may be referenced by one or more model instances (which themselves are defined in individual simulations).

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|name|string|true|Name of the model.|
|version|string|true|Version of the model.|
|repo|string|true|The name of the repository definition where this model can be downloaded from.|
|arch|string|false|Architecture of the model that should be downloaded. If more than one architecture of a model should be downloaded, then an additional model (with a different name) can be defined for each architecture.|
|schema|string|false|Define the URI schema for the model.|
|channels|[object]|false|Some models (i.e. Simbus) require specification of channels.|
|» name|string|false|The name of the channel, used when connecting this channel to the SimBus.|
|» alias|string|false|The alias of the channel, used when the channel name will be determined elsewhere.|
|» expectedModelCount|integer|false|Indicates how many models are expected to connect to this channel (used by SimBus only).|
|» selectors|object|false|Identifying information used to identify objects within the system (e.g. giving a specific 'label' to an object).|
|»» **additionalProperties**|string|false|none|
|» annotations|object|false|Non identifying information (i.e. information specific to the object itself).|
|»» **additionalProperties**|string|false|none|

<h2 id="tocS_File">File</h2>

<a id="schemafile"></a>
<a id="schema_File"></a>
<a id="tocSfile"></a>
<a id="tocsfile"></a>

```yaml
name: string
uri: string
repo: string
processing: string
generate: string
modelc: true

```

Define a file which will be used by a model of the composed simulation.
File processing follows the sequence; all `uri` nodes are processed (e.g. downloaded/copied), all `processing` commands are executed, finally all `generate` commands are executed.

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|name|string|true|Path of the file relative to the root of the simulation package. This is the final path, after download or generation. When no `processing` or `generate` node is specified, the `uri` is downloaded/copied directly to the specified `name`.|
|uri|string|false|The URI where the file (or source for the file) is located. The `uri` may be a URL or local file. If a URL requires authentication, then include a `repo` in the file definition and the authentication will be taken from that referenced repo definition.|
|repo|string|false|The name of the repository definition where authentication details for this file are located.|
|processing|string|false|Processing commands for the downloaded/copied file.|
|generate|string|false|Generate commands that produce the (final) file.|
|modelc|boolean|false|When set to `true` this file is included as a parameter to the ModelC command.|

<h2 id="tocS_ModelInstanceDefinition">ModelInstanceDefinition</h2>

<a id="schemamodelinstancedefinition"></a>
<a id="schema_ModelInstanceDefinition"></a>
<a id="tocSmodelinstancedefinition"></a>
<a id="tocsmodelinstancedefinition"></a>

```yaml
name: string
model: string
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
files:
  - name: string
    uri: string
    repo: string
    processing: string
    generate: string
    modelc: true

```

Define a model instance, which belongs to a simulation.

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|name|string|true|Name of the model instance.|
|model|string|true|The model library used by this model instance.|
|channels|[[ModelDefinition/properties/channels/items](#schemamodeldefinition/properties/channels/items)]|true|Indicates how channels are mapped to the model instance.|
|files|[[File](#schemafile)]|false|List of files used by the model instance.|

<h2 id="tocS_Simulation">Simulation</h2>

<a id="schemasimulation"></a>
<a id="schema_Simulation"></a>
<a id="tocSsimulation"></a>
<a id="tocssimulation"></a>

```yaml
name: string
parameters:
  transport: redispubsub
  environment:
    property1: string
    property2: string
files:
  - name: string
    uri: string
    repo: string
    processing: string
    generate: string
    modelc: true
models:
  - name: string
    model: string
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
    files:
      - name: string
        uri: string
        repo: string
        processing: string
        generate: string
        modelc: true

```

Define ain individual simulation.

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|name|string|true|Name of the simulation.|
|parameters|object|false|Parameters used to configure the simulation.|
|» transport|string|true|Select from the supported transports.|
|» environment|object|false|Dictionary of environment variables which control the simulation. The name of each element will be capitalized before being injected into the simulation environment.|
|»» **additionalProperties**|string|false|none|
|files|[[File](#schemafile)]|false|List of files used by the simulation and/or shared between model instances.|
|models|[[ModelInstanceDefinition](#schemamodelinstancedefinition)]|true|List of model instance definitions included in the simulation.|

#### Enumerated Values

|Property|Value|
|---|---|
|transport|redispubsub|

undefined

