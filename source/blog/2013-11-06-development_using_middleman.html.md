---
title: middleman を使ってみた
date: 2013-11-06 06:26 JST
tags: middleman
published: true
---

## 経緯

[jekyll](http://jekyllrb.com/) を使っていた Github Page を [Middleman](http://middlemanapp.com/) ([jp](http://middlemanjp.github.io/)) で書きなおしてみました．

更新していなかったので，Jekyll のことはきれいさっぱり忘れた．

ついでにドメインとりました．


## Middleman

業務の開発で使うなら，最初の一歩がもうちょっと楽になるとありがたいなーという印象．

個人使用でセットアップは一度きりと考えると，これで良いのかなという感じで割り切りました．

template がいくつか用意されているんだけれど，使いたいものが全部入りというのがなく，結局，自分で書くか template からの導入は諦める感じになりました．

activate の仕組みは便利ですね．

## code

config.rb は大体こんな感じ

helper はここにおいておいて良いのかな？？？

```ruby

activate :i18n, langs: :ja

# blog
activate :blog do |blog|
  blog.prefix = "blog"
  blog.layout = "blog_layout"
  blog.tag_template = "blog/tag.html"
  blog.calendar_template = "blog/calendar.html"
  blog.paginate = true
end
activate :directory_indexes
page "/feed.xml", :layout => false

# syntax highlight
set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, smartypants: true
set :haml, { ugly: true }
activate :rouge_syntax

helpers do
  def blog_tag_for(tag)
    content_tag(:span, class: 'tag label fa fa-tag') do
      link_to tag, tag_path(tag)
    end
  end
end

activate :deploy do |deploy|
  deploy.method = :git
  deploy.branch = :master
end
```

syntax highlight で pre タグが改行されてしまって左に余白ができてしまうのに困っていたら，良さそうな解決方法が見つかって良かった．
=> [MiddlemanでMarkdownでpre要素を使う時に出てしまう余分な余白を消す方法](http://qiita.com/kumanoayumi/items/3e39936882db5aa912d6)


## github.io

Github Pages をカスタムドメインでホスティングしたんだけれど，うまいこと反映されなくて長いことはまった．

はまったところは 3 点あって，


### ひとつは `gh-pages` ブランチがあれば，そっちが優先されると思っていた点．

username/username.github.io だと，`master` ブランチが使われるんですね．Jeykill でもそうだったのに．．．

=> [middleman-blogをgithubでホストする](http://blog.coiney.com/2013/06/21/host-middleman-blog-on-github/)


### 2 点目は，`CNAME` の置き場所．

プロジェクト直下においていたのが間違いで，`/source` 以下に配置しないといけなかった．

ビルド後のファイル構成を考えればすぐ分かりそうなもんでした．．．


### 最後は，ホスティング先の勘違い．

上の理由 (CNAME が配置されていない状態) から，`username.github.io` に展開されているのに，カスタムドメインの方を見に行っていて，いつまでたっても反映されないなーとやっていた．

これは，github のプロジェクトページの`Setting > GitHub Pages` のところを見ると，

> Your site is published at http://username.github.io

といった風に展開先が表示されるので確認できます．


## 雑感

+ 静的サイトを作るのにちゃんと使えそう
+ 少ないながらも開発に必要な道具が割と揃ってる (or 組み込める)
+ livereload 便利
+ Frontmatter 便利
+ ruby, Padrino の資産活用できて良い
+ JS, CSS, WebFonts などの管理 => Bower とか?
+ ファイル構成はもうちょっと整理したほうが．．．
+ middleman-blog 使っても，いきなりきれいなブログサイトなんかできないよ！

## おわり

とりあえず，徐々にサイト作っていきます

(なるべく更新したい
