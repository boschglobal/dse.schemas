---
title: "Schema: Propagator"
linkTitle: "Propagator"
---

(v0.0.1)

<h2 id="tocS_Propagator">Propagator</h2>

<a id="schemapropagator"></a>
<a id="schema_Propagator"></a>
<a id="tocSpropagator"></a>
<a id="tocspropagator"></a>

```yaml
kind: Propagator
metadata:
  name: string
  labels:
    property1: string
    property2: string
  annotations:
    property1: string
    property2: string
spec:
  options:
    direction: both
  signals:
    - signal: string
      target: string
      encoding:
        linear:
          min: 0
          max: 0
          factor: 0
          offset: 0
        mapping:
          - name: string
            source: 0
            target: 0
            range:
              min: 0
              max: 0

```

A propagator definition.

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
|spec|[PropagatorSpec](#schemapropagatorspec)|true|none|

#### Enumerated Values

|Property|Value|
|---|---|
|kind|Propagator|

<h2 id="tocS_PropagatorSpec">PropagatorSpec</h2>

<a id="schemapropagatorspec"></a>
<a id="schema_PropagatorSpec"></a>
<a id="tocSpropagatorspec"></a>
<a id="tocspropagatorspec"></a>

```yaml
options:
  direction: both
signals:
  - signal: string
    target: string
    encoding:
      linear:
        min: 0
        max: 0
        factor: 0
        offset: 0
      mapping:
        - name: string
          source: 0
          target: 0
          range:
            min: 0
            max: 0

```

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|options|object|false|none|
|» direction|string|false|none|
|signals|[[SignalEncoding](#schemasignalencoding)]|false|A list of signals belonging to this propagator.|

#### Enumerated Values

|Property|Value|
|---|---|
|direction|both|
|direction|forward|
|direction|reverse|

<h2 id="tocS_SignalEncoding">SignalEncoding</h2>

<a id="schemasignalencoding"></a>
<a id="schema_SignalEncoding"></a>
<a id="tocSsignalencoding"></a>
<a id="tocssignalencoding"></a>

```yaml
signal: string
target: string
encoding:
  linear:
    min: 0
    max: 0
    factor: 0
    offset: 0
  mapping:
    - name: string
      source: 0
      target: 0
      range:
        min: 0
        max: 0

```

A signal encoding definition.

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|signal|string|true|The name of the signal.|
|target|string|false|none|
|encoding|object|false|none|
|» linear|object|false|none|
|»» min|number|false|none|
|»» max|number|false|none|
|»» factor|number|false|none|
|»» offset|number|false|none|
|» mapping|[object]|false|none|
|»» name|string|false|none|
|»» source|number|false|none|
|»» target|number|false|none|
|»» range|object|false|none|
|»»» min|number|false|none|
|»»» max|number|false|none|

undefined

