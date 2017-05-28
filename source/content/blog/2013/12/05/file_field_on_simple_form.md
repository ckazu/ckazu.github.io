---
title: simple_form で binary 型フィールドの file_field を使う
date: 2013-12-05T22:35:00+09:00
tags: ["rails"]
---

## simple_form

<https://github.com/plataformatec/simple_form> は，煩雑になりがちなフォームの記述をシンプルにしてくれます．

```ruby
- form_for @user do |f|
  %li
    name:
    = f.text_field :name
  %li
    email:
    = f.email_field :mail_address
  %li
    password:
    = f.password_field :password
```

通常，このように記述するところを，次のように書くことができます．

```ruby
- form_for @user do |f|
  = f.input :name
  = f.input :mail_address
  = f.input :password
```

全部，input で済ませることができます．

## binary 型

基本的には DB のカラム定義を見て生成してくれますが，次のように，binary 型のカラムにファイルをアップロードしようとしたところエラーとなってしまいます．

```ruby
- form_for @user do |f|
  = f.file_field :image_file # <= これを

- form_for @user do |f|
  = f.input :image_file # <= このようにするとエラー
```

この場合，<https://github.com/plataformatec/simple_form#available-input-types-and-defaults-for-each-column-type> にあるような :as オプションを使用することで回避することができます．

```ruby
- form_for @user do |f|
  = f.input :image_file, as: :file
```
