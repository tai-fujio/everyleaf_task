
## データ構造の設計　　
#### User　
|カラム名|データ型|
|:--:|:--:|
|id|integer|
|user_name|string|
|user_email|string|
|password_digest|string|

#### Task　　
|カラム名|データ型|
|:--:|:--:|
|id|integer|
|user_id(FK)|references|
|task_name|string|
|task_details|text|
|task_deadline|date|
|task_priority|integer|
|task_status|integer|
|labeling_id(FK)|references|

#### Commit
|カラム名|データ型|
|:--:|:--:|
|id|integer|
|user_id(FK)|integer|
|task_id(FK)|integer|

#### labeling
|カラム名|データ型|
|:--:|:--:|
|id|integer|
|labeling_name|string|
