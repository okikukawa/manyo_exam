# README
tasksテーブル
---
|Column|Type|Options|
|------|----|-------|
|title|string|
|content|text|
|deadline|date|
|priority|stirng|
|status|string|
|user_id|integer|


usersテーブル
---
|Column|Type|Options|
|------|----|-------|
|name|string|
|email|string|
|password_digest|string|

labelsテーブル
---
|Column|Type|Options|
|------|----|-------|
|name|string|

labelsテーブル
---
|Column|Type|Options|
|------|----|-------|
|task_id|integer|
|label_id|integer|
