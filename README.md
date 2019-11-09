# MemoFrame

## Overview
メッセージを表示するだけのアプリです。

ここにタスクなど、今自分が何をしているのかということを書いて、作業が他のことに逸れないようにするという目的から作ったものになります。

## GET
http://yourhost/api/message?key=GET_KEY （GET_KEYはサーバー（<https://github.com/satoshi-kuhara/MemoFrame-Server>）側のenvで設定します。）
```
{
    "message": "Message",
    "color": 1
}
```
この構造のデータを受け取ることにより、以下のような表示がされます。
![スクリーンショット 2019-11-08 23 58 06](https://user-images.githubusercontent.com/57531377/68486088-c8bca900-0283-11ea-8c97-4a309e6775c2.png)

## アプリの説明
### 左下の丸
このアプリは、APIを一定間隔で呼んでいるため、メッセージの内容が変わらなくとも、通信が発生します。

その通信を止めるための機能です。タップすると四角になります。

再度タップすると、通信が再開されます。

### 右下の丸
それぞれの色の丸をタップすると、背景の色が切り替わります。

単調では飽きてしまうので、追加実装してみました。

なお、APIからデータを取得するとき、colorの値によって色が変わります。

## 動画
https://www.youtube.com/watch?v=rYCypHYrits

## あとがき
今後はサーバー側をFirebaseでやってみたいと考えています。
