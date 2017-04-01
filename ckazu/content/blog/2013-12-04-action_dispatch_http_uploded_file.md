---
title: rails でファイルをアップロードする際の挙動
date: 2013-12-04T22:18:00+09:00
tags: ["rails"]
---

## 経緯

[前回](/blog/2013/12/04/image_upload_to_ar_db/)，画像ファイルをアップロードして DB に保存する記事を書きました．

実際にファイルはどうやって DB に保存されるのかについて補足します．


## params をみる

前回と同じプロジェクトで進めます．

```ruby
  def create
    binding.pry # <= ここの params を確認したい
    @user = User.new(user_params)
    @user.icon = params[:user][:icon].read
    @user.icon_content_type = params[:user][:icon].content_type
  ...
```

実際にファイルをアップロードした時のパラメータを見てみます．

```
[1] pry(#<UsersController>)> params[:user][:icon]
=> #<ActionDispatch::Http::UploadedFile:0x007fbdcbbe0ba0
 @content_type="image/jpeg",
 @headers=
  "Content-Disposition: form-data; name=\"user[icon]\"; filename=\"laughing_man.jpg\"\r\nContent-Type: image/jpeg\r\n",
 @original_filename="laughing_man.jpg",
 @tempfile=
  #<File:/var/folders/j6/4l756wsn2538zn3b31sgf3yc0000gn/T/RackMultipart20131204-93143-5kjzat>>
```

ということで，ブラウザ上のフォームからアップロードしたファイルの正体は `ActionDispatch::Http::UploadedFile` のようです．

## Tempfile

この `@tempfile` がファイルの実体です．

```
[2] pry(#<UsersController>)> params[:user][:icon].tempfile
=> #<File:/var/folders/j6/4l756wsn2538zn3b31sgf3yc0000gn/T/RackMultipart20131204-93143-5kjzat>
[3] pry(#<UsersController>)> params[:user][:icon].tempfile.class
=> Tempfile
[4] pry(#<UsersController>)> params[:user][:icon].tempfile.path
=> "/var/folders/j6/4l756wsn2538zn3b31sgf3yc0000gn/T/RackMultipart20131204-93143-5kjzat"
```

ここからわかるように，アップロードしたファイルは一時的に `/var/folders/j6/4l756wsn2538zn3b31sgf3yc0000gn/T/RackMultipart20131204-93143-5kjzat` のような場所に格納されます．

※ 通常は保存されず，すぐに削除されます．

## ちなみに，

`ActionDispatch::Http::UploadedFile` に対して `read` メソッドを呼ぶと，バイナリが取得できますが，一度呼ぶと取得できなくなります．

```

[5] pry(#<UsersController>)> params[:user][:icon].read
=> "\x89PNG\r\n\x1A\n\x00\x00\x00\rIHDR\x00\x00\x00\x92\x00\x00\x00\x92\b\x06\x00\x00\x00\xAE{\x93\x8E\x00\x00\x00\x19tEXtSoftw
...
[6] pry(#<UsersController>)> params[:user][:icon].read
=> ""
```

なので，以下のようにプリントデバッグしようとするとはまります(はまりました)．

```ruby
  def create
    @user = User.new(user_params)
    pp params[:user][:icon].read # <= ここで読んでしまうと
    @user.icon = params[:user][:icon].read # <= ここでは取得できない
    @user.icon_content_type = params[:user][:icon].content_type
  ...
```
