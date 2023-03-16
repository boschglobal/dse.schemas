---
title: "Schema: SignalData"
linkTitle: "SignalData"
---

(v0.0.1)

<h2 id="tocS_SignalData">SignalData</h2>

<a id="schemasignaldata"></a>
<a id="schema_SignalData"></a>
<a id="tocSsignaldata"></a>
<a id="tocssignaldata"></a>

```yaml
Data = [[0..N],[0..N]]

```

MsgPack encoded Signal Data. Number of elements in each nested array should be identical.

### Properties

oneOf

|Name|Type|Required|Description|
|---|---|---|---|
|*anonymous*|[SignalUid](#schemasignaluid)|false|Signal UID.|

xor

|Name|Type|Required|Description|
|---|---|---|---|
|*anonymous*|[SignalValueNumeric](#schemasignalvaluenumeric)|false|Numeric signal value. The value may be encoded as any integer or float type.|

xor

|Name|Type|Required|Description|
|---|---|---|---|
|*anonymous*|[SignalValueBinary](#schemasignalvaluebinary)|false|Binary signal value.|

<h2 id="tocS_SignalUid">SignalUid</h2>

<a id="schemasignaluid"></a>
<a id="schema_SignalUid"></a>
<a id="tocSsignaluid"></a>
<a id="tocssignaluid"></a>

```yaml
0

```

Signal UID.

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|*anonymous*|integer(int32)|false|Signal UID.|

<h2 id="tocS_SignalValueNumeric">SignalValueNumeric</h2>

<a id="schemasignalvaluenumeric"></a>
<a id="schema_SignalValueNumeric"></a>
<a id="tocSsignalvaluenumeric"></a>
<a id="tocssignalvaluenumeric"></a>

```yaml
0

```

Numeric signal value. The value may be encoded as any integer or float type.

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|*anonymous*|number(double)|false|Numeric signal value. The value may be encoded as any integer or float type.|

<h2 id="tocS_SignalValueBinary">SignalValueBinary</h2>

<a id="schemasignalvaluebinary"></a>
<a id="schema_SignalValueBinary"></a>
<a id="tocSsignalvaluebinary"></a>
<a id="tocssignalvaluebinary"></a>

```yaml
string

```

Binary signal value.

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|*anonymous*|string(binary)|false|Binary signal value.|

undefined

