# -*- coding: utf-8 -*-
---
title: rails で画像ファイルを DB に保存する
date: 2013-12-04 00:50 JST
tags: rails
---

## rails で画像を保存する

rails 画像を扱うには，<https://github.com/thoughtbot/paperclip> や <https://github.com/carrierwaveuploader/carrierwave> といった便利な画像アップローダの gem がありますが，ちょっとしたアイコンやアバター，ロゴ，バナー画像などの類で，加工も必要ないような場合には DB にバイナリで突っ込んでおくくらいが手軽で良さそうです．

### 前提

```sh
$ rails new test_app
$ vi Gemfile
Gemfile に haml-rails を追加
$ bundle install
$ rails g scaffold user name icon:binary icon_content_type
$ rake db:migrate
```

以上の作業後の状態です．


### 画像を保存するカラム

上で生成しているように，今回は `User#icon` に保存することにします．

また，ファイルタイプを保持しておくために，`User#icon_content_type` も同時に用意しておきます．

それから，デフォルトの状態だと User#icon は blob なので，必要に応じて変更します．

```ruby
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.binary :icon, limit: 10.megabyte # <= limit を指定する
      t.string :icon_content_type

      t.timestamps
    end
  end
end
```

サンプルは Sqlite3 で作ってしまったので関係ないのですが．．．

なにはともあれ，migration します．

```sh
$ rake db:migrate:redo
```


## コントローラでバイナリをセットする

icon のバイナリデータとファイルタイプは create (update も) アクション内でパラメータからセットするようにします．

rails4 で scaffold を使用すると，`user_params` のようなメソッドが生えるので，今回は `icon`, `icon_content_type` をそこから除外してしまうことにします．

```ruby
app/controllers/users_controller.rb

class UsersController < ApplicationController
...
  def create
    @user = User.new(user_params)
    @user.icon = params[:user][:icon].read # <= バイナリをセット
    @user.icon_content_type = params[:user][:icon].content_type # <= ファイルタイプをセット

    ...
  end
  ...
  private
    def user_params
      params.require(:user).permit(:name) # <= icon, icon_content_type を削除
    end
...
end
```


## フォームの変更

`User#icon` にファイルをアップロードできるように変更します．

![フォームの変更](images/20131204_1.png)

```ruby
app/views/users/_form.html.haml

= form_for @user do |f|
  - if @user.errors.any?
    #error_explanation
      %h2= "#{pluralize (@user.errors.count, "error")} prohibited this user from being saved:"
      %ul
        - @user.errors.full_messages.each do |msg|
          %li= msg

  .field
    = f.label :name
    = f.text_field :name
  .field
    = f.label :icon
    = f.file_field :icon # <= text_field を file_field に変更
  -# icon_content_type はフォームから削除しておく
  .actions
    = f.submit 'Save'
```

ここまでで，保存ができるようになりましたが，index, show アクションで `User#icon` がエラーになってしまいます．


## 保存した画像を表示できるようにする

解消するための下準備として，画像を表示できるようにします．

画像専用のルーティングを定義します．

```ruby
config/routes.rb

SampleApp::Application.routes.draw do
  resources :users do
    member { get :icon }
  end
end
```

```sh
$ rake routes
   Prefix Verb   URI Pattern               Controller#Action
icon_user GET    /users/:id/icon(.:format) users#icon
...
```

コントローラに `icon` アクションを追加し，`send_data` メソッドにより画像を取得します．

```ruby
app/controllers/users_controller.rb

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :icon] # <= scaffold の場合はここに :icon を追加すると楽

  ...
  def icon
    send_data(@user.icon, type: @user.icon_content_type, disposition: :inline)
  end
  ...
end
```

これで，`/users/:id/icon` で画像が表示できるようになりました．


## ビューの変更

最後に，index, show のビューを，`/users/:id/icon` の画像を使用するように変更します．

それぞれの `icon` の表示部分を以下のように変更します．

```ruby
image_tag icon_user_path(user)
```

![ビューの変更](images/20131204_2.png)

これで完了です．
