---
title: "Schema: Simulation"
linkTitle: "Simulation"
---

(v0.0.1)

<h2 id="tocS_Simulation">Simulation</h2>

<a id="schemasimulation"></a>
<a id="schema_Simulation"></a>
<a id="tocSsimulation"></a>
<a id="tocssimulation"></a>

```yaml
kind: Simulation
metadata:
  name: project
  annotations:
    input: somefile.json
    generator: parse2ast
spec:
  simulation:
    arch: linux-amd64
    channels:
      - name: physical
      - name: network
        networks:
          - name: CAN
            mime_type: application/x
    uses:
      - name: model.linear
        url: https://github.com/boschglobal/dse.fmi
        version: 1.1.15
        path: model/linear/path
    vars:
      - name: enable
        value: true
    stacks:
      - name: stack_name
        stacked: true
        arch: linux-amd64
        models:
          - name: linear
            model: model.linear
            channels:
              - name: physical
                alias: scalar
            env:
              - name: SIMBUS_LOGLEVEL
                value: 4
            workflows:
              - name: generate-fmimcl
                vars:
                  - name: FMU_DIR
                    value: "{{.PATH}}/fmu"

```

Simulation Abstract Syntax Tree (AST).

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
|spec|[SimulationSpec](#schemasimulationspec)|true|none|

#### Enumerated Values

|Property|Value|
|---|---|
|kind|Simulation|

<h2 id="tocS_SimulationSpec">SimulationSpec</h2>

<a id="schemasimulationspec"></a>
<a id="schema_SimulationSpec"></a>
<a id="tocSsimulationspec"></a>
<a id="tocssimulationspec"></a>

```yaml
arch: linux-amd64
channels:
  - name: string
    networks:
      - name: string
        mime_type: string
uses:
  - name: string
    url: string
    version: string
    path: string
vars:
  - name: string
    value: string
    reference: uses
stacks:
  - name: string
    arch: linux-amd64
    stacked: true
    env:
      - name: string
        value: string
        reference: uses
    models:
      - name: string
        model: string
        arch: linux-amd64
        channels:
          - name: string
            alias: string
        env:
          - name: string
            value: string
            reference: uses
        workflows:
          - name: string
            uses: string
            vars:
              - name: string
                value: string
                reference: uses

```

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|arch|string|true|The default system architecture for the simulation.|
|channels|[[SimulationChannel](#schemasimulationchannel)]|true|The list of channels available in this simulation.|
|uses|[[Uses](#schemauses)]|false|The list of uses references to external artifacts or repos.|
|vars|[[Var](#schemavar)]|false|The list of variables available to models in this simulation.|
|stacks|[[Stack](#schemastack)]|true|The list of stacks contained within this simulation.|

<h2 id="tocS_SimulationChannel">SimulationChannel</h2>

<a id="schemasimulationchannel"></a>
<a id="schema_SimulationChannel"></a>
<a id="tocSsimulationchannel"></a>
<a id="tocssimulationchannel"></a>

```yaml
name: string
networks:
  - name: string
    mime_type: string

```

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|name|string|true|The name of this channel.|
|networks|[[SimulationNetwork](#schemasimulationnetwork)]|false|A list of networks associated with a channel.|

<h2 id="tocS_SimulationNetwork">SimulationNetwork</h2>

<a id="schemasimulationnetwork"></a>
<a id="schema_SimulationNetwork"></a>
<a id="tocSsimulationnetwork"></a>
<a id="tocssimulationnetwork"></a>

```yaml
name: string
mime_type: string

```

A network definition.

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|name|string|true|The name of the network signal (on the associated channel).|
|mime_type|string|true|MIME type defining the network.|

<h2 id="tocS_ModelChannel">ModelChannel</h2>

<a id="schemamodelchannel"></a>
<a id="schema_ModelChannel"></a>
<a id="tocSmodelchannel"></a>
<a id="tocsmodelchannel"></a>

```yaml
name: string
alias: string

```

A model <-> simulation channel mapping.

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|name|string|true|The name of the channel in the simulation.|
|alias|string|false|The name (alias) of the channel in the model.|

<h2 id="tocS_Uses">Uses</h2>

<a id="schemauses"></a>
<a id="schema_Uses"></a>
<a id="tocSuses"></a>
<a id="tocsuses"></a>

```yaml
name: string
url: string
version: string
path: string

```

Defines an external resource used by the simulation.

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|name|string|true|The name of uses item (to be used for references).|
|url|string|true|The URL of the uses item.|
|version|string|false|The tag/version of the uses item.|
|path|string|false|A sub-path relative to the uses artefact (URL or ZIP file) where the item is located.|

<h2 id="tocS_Var">Var</h2>

<a id="schemavar"></a>
<a id="schema_Var"></a>
<a id="tocSvar"></a>
<a id="tocsvar"></a>

```yaml
name: string
value: string
reference: uses

```

A variable definition.

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|name|string|true|A variable name.|
|value|string|true|A coresponding variable value.|
|reference|string|false|This value is derived from the specified reference (e.g. a downloaded file) The resouce name is specified in the value.|

#### Enumerated Values

|Property|Value|
|---|---|
|reference|uses|

<h2 id="tocS_Stack">Stack</h2>

<a id="schemastack"></a>
<a id="schema_Stack"></a>
<a id="tocSstack"></a>
<a id="tocsstack"></a>

```yaml
name: string
arch: linux-amd64
stacked: true
env:
  - name: string
    value: string
    reference: uses
models:
  - name: string
    model: string
    arch: linux-amd64
    channels:
      - name: string
        alias: string
    env:
      - name: string
        value: string
        reference: uses
    workflows:
      - name: string
        uses: string
        vars:
          - name: string
            value: string
            reference: uses

```

A stack definition which composes one or more models as a logical unit of the simulation.

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|name|string|true|The name of the stack.|
|arch|string|false|The architecture of the stack, if different from the simulation default architecture.|
|stacked|boolean|false|Indicate that models in this stack should be run in a 'stacked' configuration (i.e. as a single process).|
|env|[[Var](#schemavar)]|false|Sets environment variables in the runtime of this simulation stack.|
|models|[[Model](#schemamodel)]|true|The list of models belonging to this simulation stack.|

<h2 id="tocS_Model">Model</h2>

<a id="schemamodel"></a>
<a id="schema_Model"></a>
<a id="tocSmodel"></a>
<a id="tocsmodel"></a>

```yaml
name: string
model: string
arch: linux-amd64
channels:
  - name: string
    alias: string
env:
  - name: string
    value: string
    reference: uses
workflows:
  - name: string
    uses: string
    vars:
      - name: string
        value: string
        reference: uses

```

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|name|string|true|The name of the model in the simulation (i.e. the model instance name).|
|model|string|true|The name of the model this instance represents.|
|arch|string|false|The architecture of the model, if different from the stack or simulation default architecture.|
|channels|[[ModelChannel](#schemamodelchannel)]|true|An array of model <-> simulaiton channel mappings.|
|env|[[Var](#schemavar)]|false|Sets environmnet variables in the runtime of this model.<br>Values defined here supersede those set in the simulation stack (of the model).|
|workflows|[[Workflow](#schemaworkflow)]|false|An array of workflows used to construct/process artefacts used by this model instance.|

<h2 id="tocS_Workflow">Workflow</h2>

<a id="schemaworkflow"></a>
<a id="schema_Workflow"></a>
<a id="tocSworkflow"></a>
<a id="tocsworkflow"></a>

```yaml
name: string
uses: string
vars:
  - name: string
    value: string
    reference: uses

```

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|name|string|true|The name of the workflow.|
|uses|string|false|If a workflow is located in a different repository than the model, indicate that here.|
|vars|[[Var](#schemavar)]|false|Set  variable values to be used by the workflow.|

undefined

