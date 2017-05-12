+++
date = "2017-05-13T01:32:41+09:00"
title = "rails 5 にアップデートしたときにやったこと"
tags = ['rails']
+++

以前，rails 5.0 にあげたときにやったことのメモ．
rails 6 とか、rails 5.1 とかのときにも役に立つといいな．

## やったこと

### 事前準備

* テストコードが不足していることがないか確認する
  * coverage などで確認
* 既存バージョンで rails 以外のバージョン指定を外して bundle update してみる
  * テスト、挙動が問題ないところまでアップデートする
  * 最新にならないものはバージョン指定する
* rails guide の upgrading ruby on rails を読む
  * http://edgeguides.rubyonrails.org/upgrading_ruby_on_rails.html
* 社内のプロダクトやウォッチしている OSS でアップデートしているものがあれば目を通す

### 手順

* rails のバージョン指定を外して bundle update する
  * 上がらない gem は github の master を使うなど、gem の issue を確認しつつ個別に対応していく
* `rails app:update` を実行する
  * 変更に問題ない部分をコミット
* `rails db:migrate` して db/scheme.rb をコミット（rails 5 の場合）
* `rails new <APPNAME>` を別ディレクトリに同名の APPNAME で作成する
  * ディレクトリごとコピーして差分を確認。問題ない部分をコミット。
* テストを実行する
  * エラーになる部分を対応する。warning はとりあえず無視。
* `rails s` 起動して挙動を確認する
  * 問題があれば対応する
* DEPRECATION WARNING の対応をする
  * テスト実行やサーバ起動時に出る warning を対応していく
  * コードを修正したり、gem のバージョンを指定するなどの対応になる
  * ある gem の warnig を解消するのに、依存している他の gem のバージョンを下げないといけないケースの場合、無理して解消しないようにする。そのうち対応されるはず。
* 一通り対応が終わったら、再度、バージョン指定を外して bundle update してみる
  * 問題があっても、リリース直後は頻繁に gem のアップデートがあるので、解消していることもある

## tips など

* /config/environments/staging.rb は rails new しても存在しないので、staging などを使用している場合コミットから漏れるので気をつける
* デプロイできるかどうかも確認しておかないと、いざという時に慌てる
* 手元で、production 相当の設定でも一応確認しておいたほうが良い。assets precompile とかでデプロイしてから気づくこともある。
* rails 本体に取り込まれて必要の無くなった gem とかもたまにあるので対応する。 quiet_assets とか
