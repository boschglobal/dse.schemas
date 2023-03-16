---
title: "Schema: SignalGroup"
linkTitle: "SignalGroup"
---

(v0.0.1)

<h2 id="tocS_SignalGroup">SignalGroup</h2>

<a id="schemasignalgroup"></a>
<a id="schema_SignalGroup"></a>
<a id="tocSsignalgroup"></a>
<a id="tocssignalgroup"></a>

```yaml
kind: SignalGroup
metadata:
  name: string
  labels:
    property1: string
    property2: string
  annotations:
    property1: string
    property2: string
spec:
  signals:
    - signal: string
      annotations:
        property1: string
        property2: string

```

A signal group definition.

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
|» signals|[[Signal](#schemasignal)]|true|A list of signals belonging to this signal group.|

#### Enumerated Values

|Property|Value|
|---|---|
|kind|SignalGroup|

<h2 id="tocS_Signal">Signal</h2>

<a id="schemasignal"></a>
<a id="schema_Signal"></a>
<a id="tocSsignal"></a>
<a id="tocssignal"></a>

```yaml
signal: string
annotations:
  property1: string
  property2: string

```

A signal definition.

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|signal|string|true|The name of the signal.|
|annotations|object|false|Non identifying information (i.e. information specific to the object itself).|
|» **additionalProperties**|string|false|none|

undefined

