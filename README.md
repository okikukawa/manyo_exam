バージョン情報
---


ruby 2.6.5<br>
rails 5.2.4<br>
<h1>gem 3.0.3</h1>

Herokuへのデプロイ手順
---
前提条件
・herokuがインストール済みであること
・herokuへログインできること

1. アプリケーションを作成
`heroku create`
2. herokuへpush
`git push heroku master`
3. テーブル作成
`heroku run rails db:migrate`




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


task_labelテーブル
---
|Column|Type|Options|
|------|----|-------|
|task_id|integer|
|label_id|integer|
