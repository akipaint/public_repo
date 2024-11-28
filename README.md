# The-View
 景色の写真投稿サイトです。<br >
 旅行先の景色や好きな景色を位置情報付きで共有できます。 <br >
 レスポンシブ対応しているのでスマホからもご確認いただけます。
 <img width="1400" alt="スクリーンショット 2020-05-07 0 06 18" src="https://protopedia.net/pic/1c7c097f-8147-494e-b25e-66a6a4996c09.png">
 <img width="350" height="700" src= "https://user-images.githubusercontent.com/60876388/81476543-643bd000-924d-11ea-9d26-cac305ca9f91.jpeg">

# URL
https://echose.net <br >
画面中部のマッチ作品を探すから、コンテンツを確認することができます。

# 使用技術
- Ruby 3.1.6
- Ruby on Rails 7.0.8
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
- CircleCi CI/CD
  - GitHub Actions
- RSpec
- GCP
  - Cloud Translation API

# システム構成図
<img width="995" alt="スクリーンショット 2020-05-07 11 14 01" src="https://protopedia.net/pic/38d10589-8f28-4d33-acac-b8daafe38c99.png">

## CircleCi CI/CD
- Githubへのpush時に、RspecとRubocopが自動で実行されます。
- masterブランチへのpushでは、RspecとRubocopが成功した場合、ECS(Fargate)への自動デプロイが実行されます

# 機能一覧
- ユーザー登録、ログイン機能(devise)
- 投稿機能
  - 画像投稿(refile/active storage)
- いいね機能(Ajax)
  - ランキング機能
- コメント機能(Ajax)
- フォロー機能(Ajax)
- ページネーション機能(kaminari)
  - 無限スクロール(Ajax)
- 検索機能(ransack)

# テスト
- RSpec
  - 単体テスト(model)
  - 機能テスト(request)
  - 統合テスト(feature)
