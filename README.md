# The-View
 画像と音楽をマッチさせる作品投稿サイトです。<br >
 ユーザの作品同士マッチさせ新たな共同作品を生み出します。 <br >
 <img width="1400" alt="スクリーンショット 2020-05-07 0 06 18" src="https://protopedia.net/pic/1c7c097f-8147-494e-b25e-66a6a4996c09.png">

# URL
https://echose.net <br >
画面中部のマッチ作品を探すから、コンテンツを確認することができます。

# 使用技術
- Ruby 3.1.6
- Ruby on Rails 7.0.8
- Python (original API)
- MySQL 8.0
- Nginx
- Puma
- AWS
  - VPC
  - ECS (Fargate)
  - ECR
  - RDS (MySQL)
  - Route53
- Docker/Docker-compose

- GCP
  - Cloud Translation API

# システム構成図
<img width="995" alt="スクリーンショット 2020-05-07 11 14 01" src="https://protopedia.net/pic/38d10589-8f28-4d33-acac-b8daafe38c99.png">


# 機能一覧
- ユーザー登録、ログイン機能(devise)
- 投稿機能
  - 画像投稿(refile/active storage)
  - 音楽投稿(refile/active storage)
- いいね機能(Ajax)
- マッチング機能(Python original API)
- フォロー機能(Ajax)
