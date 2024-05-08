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
    ? property1
    ? property2
spec:
  signals:
    - signal: string
      transform:
        linear:
          factor: 0
          offset: 0
      annotations:
        ? property1
        ? property2

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
|»» **additionalProperties**|any|false|none|
|spec|[SignalGroupSpec](#schemasignalgroupspec)|true|none|

#### Enumerated Values

|Property|Value|
|---|---|
|kind|SignalGroup|

<h2 id="tocS_SignalGroupSpec">SignalGroupSpec</h2>

<a id="schemasignalgroupspec"></a>
<a id="schema_SignalGroupSpec"></a>
<a id="tocSsignalgroupspec"></a>
<a id="tocssignalgroupspec"></a>

```yaml
signals:
  - signal: string
    transform:
      linear:
        factor: 0
        offset: 0
    annotations:
      ? property1
      ? property2

```

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|signals|[[Signal](#schemasignal)]|true|A list of signals belonging to this signal group.|

<h2 id="tocS_Signal">Signal</h2>

<a id="schemasignal"></a>
<a id="schema_Signal"></a>
<a id="tocSsignal"></a>
<a id="tocssignal"></a>

```yaml
signal: string
transform:
  linear:
    factor: 0
    offset: 0
annotations:
  ? property1
  ? property2

```

A signal definition.

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|signal|string|true|The name of the signal.|
|transform|object|false|A transformation definition.|
|» linear|object|false|Represents a linear transformation in the form:<br>    f(X) = X * factor + offset.|
|»» factor|number(double)|true|none|
|»» offset|number(double)|true|none|
|annotations|object|false|Non identifying information (i.e. information specific to the object itself).|
|» **additionalProperties**|any|false|none|

undefined

