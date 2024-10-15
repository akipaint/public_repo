
## 使用技術一覧
# 使用技術一覧

<!-- シールド一覧 -->
<!-- 該当するプロジェクトの中から任意のものを選ぶ-->
<p style="display: inline">
  <!-- フロントエンドのフレームワーク一覧 -->
  <img src="https://img.shields.io/badge/-Node.js-000000.svg?logo=node.js&style=for-the-badge">
  <!-- バックエンドのフレームワーク一覧 -->
  <img src="https://img.shields.io/badge/-rails-D30001.svg?logo=rasil&style=for-the-badge">
  <!-- バックエンドの言語一覧 -->
  <img src="https://img.shields.io/badge/-Ruby-CC342D.svg?logo=ruby&style=for-the-badge">

  <!-- ミドルウェア一覧 -->
  <img src="https://img.shields.io/badge/-Nginx-269539.svg?logo=nginx&style=for-the-badge">
  <img src="https://img.shields.io/badge/-MySQL-4479A1.svg?logo=mysql&style=for-the-badge&logoColor=white">

  <!-- インフラ一覧 -->
  <img src="https://img.shields.io/badge/-Docker-1488C6.svg?logo=docker&style=for-the-badge">
  <img src="https://img.shields.io/badge/-Amazon%20aws-232F3E.svg?logo=amazon-aws&style=for-the-badge">

</p>

## 目次

1. [プロジェクトについて](#プロジェクトについて)
2. [環境](#環境)
3. [ディレクトリ構成](#ディレクトリ構成)
4. [開発環境構築](#開発環境構築)
5. [トラブルシューティング](#トラブルシューティング)

<!-- READMEの作成方法のドキュメントのリンク -->
<br />
<div align="right">
    <!-- <a href="READMEの作成方法のリンク"><strong>READMEの作成方法 »</strong></a> -->
</div>
<br />
<!-- Dockerfileのドキュメントのリンク -->
<div align="right">
    <!-- <a href="Dockerfileの詳細リンク"><strong>Dockerfileの詳細 »</strong></a> -->
</div>
<br />
<!-- プロジェクト名を記載 -->

## プロジェクト名

マッチングSNS「Echose」
=======
3. [必要なツール](#必要なツール)
4. [構想](#構想)
5. [環境構築手順](#環境構築手順)
6. [使用方法](#使用方法)
7. [コーディング規約](#コーディング規約)
8. [動作確認](#動作確認)
9. [環境変数の一覧](#環境変数の一覧)

## プロジェクト名

マッチングSNS「Echose」

<!-- プロジェクトについて -->

## プロジェクトについて

Echoseは、ユーザーが投稿した画像と音楽を、マッチ度をもとにしたレコメンデーションシステムによって組み合わせ、クリエイティブな「マッチ投稿」として発信できるSNSです。このシステムは、タグを基にマッチ度を計算し、ユーザーそれぞれの作品に合った投稿を提案します。ユーザーは、最もマッチしている作品を選んで投稿することができ、投稿された作品はまた他のユーザーの投稿とマッチすることでより多角的に広がっていきます。

フロントエンドにはオーディオビジュアライザー機能によって音楽を視覚的に表現しています。バックエンドはRuby on RailsとMySQLで構築し、Pythonでマッチ度を算出するAPIを作成。これらをDockerとAWSを活用してデプロイしています。Echoseは直感的なユーザーインターフェースとマッチング機能を組み合わせ、新しい作品同士の共鳴を発信できるSNSです。


<!-- プロジェクトの概要を記載 -->

  <p align="left">
    <br />
    <!-- プロジェクト詳細にBacklogのWikiのリンク -->
    <!-- <a href="Backlogのwikiリンク"><strong>プロジェクト詳細 »</strong></a> -->
    <br />
    <br />

<p align="right">(<a href="#top">トップへ</a>)</p>

## 環境

<!-- 言語、フレームワーク、ミドルウェア、インフラの一覧とバージョンを記載 -->

<<<<<<< HEAD
| 言語・フレームワーク  | バージョン |
| --------------------- | ---------- |
| Ruby                  | 3.1        |
| MySQL                 | 8.0        |
| Node.js               | 導入を検討中    |
| Ruby on Rails         | 7.0.8      |
=======
| 言語・フレームワーク | バージョン   |
| -------------------- | ------------ |
| Ruby                 | 3.1          |
| MySQL                | 8.0          |
| Node.js              | 導入を検討中 |
| Ruby on Rails        | 7.0.8        |
>>>>>>> 8ecaa57c747a277a4822619d15989bfbd03726b5

その他のパッケージのバージョンは 管理者に質問してください

<p align="right">(<a href="#top">トップへ</a>)</p>

<<<<<<< HEAD
## ディレクトリ構成

<!-- Treeコマンドを使ってディレクトリ構成を記載 -->

❯ tree<br>
C:.<br>
├─app<br>
│  ├─assets<br>
│  │  ├─config<br>
│  │  ├─images<br>
│  │  └─stylesheets<br>
│  ├─channels<br>
│  │  └─application_cable<br>
│  ├─controllers<br>
│  │  └─concerns<br>
│  ├─helpers<br>
│  ├─javascript<br>
│  │  └─controllers<br>
│  ├─jobs<br>
│  ├─mailers<br>
│  ├─models<br>
│  │  └─concerns<br>
│  └─views<br>
│      └─layouts<br>
├─bin<br>
├─config<br>
│  ├─environments<br>
│  ├─initializers<br>
│  └─locales<br>
├─db<br>
├─lib<br>
│  ├─assets<br>
│  └─tasks<br>
├─log<br>
├─public<br>
├─storage<br>
├─tmp<br>
│  ├─cache<br>
│  │  ├─assets<br>
│  │  └─bootsnap<br>
│  │      ├─compile-cache-iseq<br>
│  │      └─compile-cache-yaml<br>
│  ├─pids<br>
│  ├─sockets<br>
│  └─storage<br>
└─vendor<br>
    └─javascript<br>

<p align="right">(<a href="#top">トップへ</a>)</p>

## 開発環境構築

<!-- コンテナの作成方法、パッケージのインストール方法など、開発環境構築に必要な情報を記載 -->

### コンテナの作成と起動

.env ファイルを以下の環境変数例と[環境変数の一覧](#環境変数の一覧)を元に作成

.env
MYSQL_ROOT_PASSWORD=password
MYSQL_HOST=db
MYSQL_PORT=3306


.env ファイルを作成後、以下のコマンドで開発環境を構築

make prepare

### 動作確認

http://127.0.0.1:3000 にアクセスできるか確認
アクセスできたら成功

### コンテナの停止

以下のコマンドでコンテナを停止することができます

docker compose down

### 環境変数の一覧

| 変数名                 | 役割                                      | デフォルト値                       | DEV 環境での値                           |
| ---------------------- | ----------------------------------------- | ---------------------------------- | ---------------------------------------- |
| MYSQL_ROOT_PASSWORD    | MySQL のルートパスワード（Docker で使用） | password                             |                                          |
| MYSQL_HOST             | MySQL のホスト名（Docker で使用）         | db                                 |                                          |
| MYSQL_PORT             | MySQL のポート番号（Docker で使用）       | 3306                               |                                          |
### コマンド一覧

| docker compose                | 実行する処理                                                            | 元のコマンド                                                                               |
| ------------------- | ----------------------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| docker compose up             | コンテナの起動                                                          | docker-compose up -d                                                                       |
| docker compose build          | イメージのビルド                                                        | docker-compose build                                                                       |
| docker compose down           | コンテナの停止                                                          | docker-compose down                                                                        |

### リモートデバッグの方法


## トラブルシューティング
=======
## 必要なツール

- Git/Github
- Docker
- WSL2(Windows のみ)

## 構想

GUI 等は`figma`に記載されているロードマップを確認して下さい。[こちらのページ](https://www.figma.com/design/26zu6jbISYjlI3Tk2b2kc7/%E3%83%9E%E3%83%83%E3%83%81%E5%9E%8BSNS%E3%83%A2%E3%83%83%E3%82%AF%E3%82%A2%E3%83%83%E3%83%97?node-id=7-2&t=9fQ4xzyVZgYfBGpK-0)

## 環境構築手順

開発に必要な環境を構築するには、以下の手順に従ってください。

1.  **WSL2/Docker のインストールと設定:**
    [こちらのページ](https://qiita.com/hoshimado/items/51c99ccaee3d4222d99d#wsl2%E3%81%AE%E6%9C%89%E5%8A%B9%E5%8C%96%E3%81%A8ubuntu%E3%81%AE%E3%82%BB%E3%83%83%E3%83%88%E3%82%A2%E3%83%83%E3%83%97) を参考に Docker 環境を構築します。`Docker環境のセットアップ手順`セクションから`Docker環境の動作確認`セクションまでを行ってください。
    <br>

2.  **Git/Github のインストールと設定:**
    [こちらのページ](https://prog-8.com/docs/git-env-win)を参考に Git と Github の環境を構築します。
    SSH Agent が有効化されていない場合は[こちらのページ](https://qiita.com/q1701/items/3cdc2d7ef7a3539f351d)を参考に有効化してください。
    <br>

3.  **パーソナルアクセストークンの発行:**
    このリポジトリの管理者に問い合わせてパーソナルアクセストークンを発行します。
    [こちらのページ](https://rfs.jp/server/git/github/personal_access_tokens.html)を参考にしてください。
    <br>

4.  **パーソナルアクセストークンを利用してリポジトリをクローン Windows の場合のみ**
    clone する際にファイルの改行コードを設定する必要があります。([参考](https://prograshi.com/platform/docker/convert-crlf-to-lf/))
    以下のコマンドを実行します。

    ```bash
     git config --global core.autocrlf input
    ```

    以下のコマンドを実行してリポジトリをクローンします。

    ```bash
    git clone https://github.com/akipaint/SNS-Web_app.git
    ```

    [こちらのページ](https://serip39.hatenablog.com/entry/2020/09/20/070000)を参考にアクセストークンを用いたクローンを行います。
    エラーが発生する場合は以下のページなどを参考にしてください。

    - [Windows で GitHub の認証をパスワードからパーソナルアクセストークンに切り替える](https://qiita.com/implicit_none/items/81f8c5569bd7be002745)

<p align="right">(<a href="#top">トップへ</a>)</p>

## 使用方法

コンテナを起動する前に、まずは Docker のソフトを起動させます。

### コンテナの起動

Docker コンテナを起動するには、以下のコマンドを実行します。

```bash
cd SNS-Web_app
docker compose run web rake db:create
docker compose up
```

初回起動時はコンテナイメージの取得とビルドに時間がかかります。

バックグラウンドで起動させたい場合は`-d`オプションをつけます

```bash
docker compose up -d
```

http://127.0.0.1:3000 にアクセスできるか確認します。
コンテナを停止するには、以下のコマンドを実行します。

```bash
docker compose down
```

<p align="right">(<a href="#top">トップへ</a>)</p>

## コーディング規約

### commit

機能を追加

```bash
"[Add]追加した機能の説明"
```

エラー処理

```bash
"[Fix]説明"
```

更新

```bash
"[Update]説明"
```

削除

```bash
"[Delete]説明"
```

### pull request

ですます調で作成して下さい。

### ブランチ作成

```bash
feature/機能説明(単語をつなぐ場合は`_`を使用)
```

<p align="right">(<a href="#top">トップへ</a>)</p>

## 動作確認

docker compose build
->
docker compose up
->
http://127.0.0.1:3000 にアクセスできるか確認
アクセスできたら成功

<p align="right">(<a href="#top">トップへ</a>)</p>

## 環境変数の一覧

| 変数名              | 役割                                      | デフォルト値 | DEV 環境での値 |
| ------------------- | ----------------------------------------- | ------------ | -------------- |
| MYSQL_ROOT_PASSWORD | MySQL のルートパスワード（Docker で使用） | password     |                |
| MYSQL_HOST          | MySQL のホスト名（Docker で使用）         | db           |                |
| MYSQL_PORT          | MySQL のポート番号（Docker で使用）       | 3306         |                |

<p align="right">(<a href="#top">トップへ</a>)</p>
>>>>>>> 8ecaa57c747a277a4822619d15989bfbd03726b5
=======
# public_SNS_repo
公開用レポジトリ
