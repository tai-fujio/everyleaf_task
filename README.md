# データ構造の設計　　
## ユーザー　　
- ユーザー名　user_name:string  
- ユーザーパスワード user_password:string  
- ユーザーメールアドレス user_email:string  
## タスク　　
- タスク名 task_name:string  
- タスク詳細　task_details:text  
- タスク期限 task_date:date  
- タスク優先順位 task_priority:integer  
- タスクステータス（未着手・着手・完了）task_status:integer  
- タスクラベリング task_labeling:boolean  
## ラベリング　　
- ビジネス business:boolean  
- プライベート private:boolean  
- 屋内 indoor:boolean
- 屋外 outdoor:boolean  
- 海外 overseas:boolean  

#### Userモデル
|カラム名|データ型|
|:--:|:--:|
|id|integer|
|name|string|
|e-mail|string|
|password_digest|string|

#### Taskモデル
|カラム名|データ型|
|:--:|:--:|
|id|integer|
|user_id(FK)|references|
|title|string|
|content|text|
|deadline|date|
|priority|string|
|status|string|

#### labelingモデル
|カラム名|データ型|
|:--:|:--:|
|id|integer|
|task_id(FK)|references|
|label_id(FK)|references|

#### Labelモデル
|カラム名|データ型|
|:--:|:--:|
|id|integer|
|name|string|

