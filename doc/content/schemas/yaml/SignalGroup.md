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
          factor: 2.5
          offset: 1
        functions:
          vector:
            lua: |
              return function(s_vector)
                return s_vector * 10
              end
          model:
            lua: |
              return function(s_model)
                return s_model + 3
              end
      annotations:
        ? property1
        ? property2
  functions:
    lua: string
  timing:
    phase: 0
    interval: 0

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
        factor: 2.5
        offset: 1
      functions:
        vector:
          lua: |
            return function(s_vector)
              return s_vector * 10
            end
        model:
          lua: |
            return function(s_model)
              return s_model + 3
            end
    annotations:
      ? property1
      ? property2
functions:
  lua: string
timing:
  phase: 0
  interval: 0

```

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|signals|[[Signal](#schemasignal)]|true|A list of signals belonging to this signal group.|
|functions|object|false|A map of function types supporting transformations of this signal group.|
|» lua|string|false|Inline Lua script.|
|timing|object|false|Signal Group time modelling, applies to all contained signals.|
|» phase|number|false|Phase offset relative to source or reference.|
|» interval|number|false|Time interval between updates, samples, or cycles.|

<h2 id="tocS_Signal">Signal</h2>

<a id="schemasignal"></a>
<a id="schema_Signal"></a>
<a id="tocSsignal"></a>
<a id="tocssignal"></a>

```yaml
signal: string
transform:
  linear:
    factor: 2.5
    offset: 1
  functions:
    vector:
      lua: |
        return function(s_vector)
          return s_vector * 10
        end
    model:
      lua: |
        return function(s_model)
          return s_model + 3
        end
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
|» linear|object|false|Represents a linear transformation in the form:<br>    $S_{\mathrm{model}} = S_{\mathrm{vector}} \cdot factor + offset$|
|»» factor|number(double)|true|none|
|»» offset|number(double)|true|none|
|» functions|object|false|Represents a function transformation in the forms: - $S_{\mathrm{model}} = f(S_{\mathrm{vector}})$<br>  This function transform is applied _after_ all other transforms.<br>- $S_{\mathrm{vector}} = f(S_{\mathrm{model}})$<br>  This function transform is applied _before_ all other transforms.|
|»» model|object|false|Determine the Model value based on the Transform of the Vector value.|
|»»» lua|string|false|Inline Lua script.|
|»» vector|object|false|Determine the Vector value based on the Transform of the Model value.|
|»»» lua|string|false|Inline Lua script.|
|» timing|object|false|Signal level time modelling.|
|»» phase|number|false|Phase offset relative to source or reference.|
|»» interval|number|false|Time interval between updates, samples, or cycles.|
|annotations|object|false|Non identifying information (i.e. information specific to the object itself).|
|» **additionalProperties**|any|false|none|

undefined

