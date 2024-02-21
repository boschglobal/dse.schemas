---
title: "Schema: ParameterSet"
linkTitle: "ParameterSet"
---

(v0.0.1)

<h2 id="tocS_ParameterSet">ParameterSet</h2>

<a id="schemaparameterset"></a>
<a id="schema_ParameterSet"></a>
<a id="tocSparameterset"></a>
<a id="tocsparameterset"></a>

```yaml
kind: ParameterSet
metadata:
  name: string
  labels:
    property1: string
    property2: string
  annotations:
    property1: string
    property2: string
spec:
  parameters:
    - parameter: string
      value: string
      annotations:
        property1: string
        property2: string

```

A parameter_set definition.

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
|spec|[ParameterSetSpec](#schemaparametersetspec)|true|none|

#### Enumerated Values

|Property|Value|
|---|---|
|kind|ParameterSet|

<h2 id="tocS_ParameterSetSpec">ParameterSetSpec</h2>

<a id="schemaparametersetspec"></a>
<a id="schema_ParameterSetSpec"></a>
<a id="tocSparametersetspec"></a>
<a id="tocsparametersetspec"></a>

```yaml
parameters:
  - parameter: string
    value: string
    annotations:
      property1: string
      property2: string

```

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|parameters|[[Parameter](#schemaparameter)]|true|A list of parameters belonging to this parameter set.|

<h2 id="tocS_Parameter">Parameter</h2>

<a id="schemaparameter"></a>
<a id="schema_Parameter"></a>
<a id="tocSparameter"></a>
<a id="tocsparameter"></a>

```yaml
parameter: string
value: string
annotations:
  property1: string
  property2: string

```

A signal parameter definition.

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|parameter|string|true|The name of the parameter.|
|value|string|false|The value of the parameter.|
|annotations|object|false|Non identifying information (i.e. information specific to the object itself).|
|» **additionalProperties**|string|false|none|

undefined

