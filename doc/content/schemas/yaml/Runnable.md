---
title: "Schema: Runnable"
linkTitle: "Runnable"
---

(v1.0.0)

<h2 id="tocS_Runnable">Runnable</h2>

<a id="schemarunnable"></a>
<a id="schema_Runnable"></a>
<a id="tocSrunnable"></a>
<a id="tocsrunnable"></a>

```yaml
kind: Runnable
metadata:
  name: target
  annotations:
    target_lib: examples/stub/lib/target.so
spec:
  tasks:
    - function: task_init
      schedule: 0
    - function: task_5ms
      schedule: 5
    - function: task_10ms
      schedule: 10
    - function: task_20ms
      schedule: 20
    - function: task_40ms
      schedule: 40

```

A Runnable definition.

### Supported annotations:
|Annotation|Description|
|---|---|
|`target_lib`|Relative path of the shared library containing the Runnable library.

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
|» tasks|[[Task](#schematask)]|true|A list of tasks belonging to this Runnable.|

#### Enumerated Values

|Property|Value|
|---|---|
|kind|Runnable|

<h2 id="tocS_Task">Task</h2>

<a id="schematask"></a>
<a id="schema_Task"></a>
<a id="tocStask"></a>
<a id="tocstask"></a>

```yaml
function: task_init
schedule: 20

```

A Runnable task definition.

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|function|string|true|The name of the function representing the task. This function<br>will be loaded from the library referenced by the Runnable<br>annotation `target_lib`.|
|schedule|integer|true|The task schedule interval (in milliseconds).|

undefined

