---
title: Middleman の記事更新を Travis-CI でする
date: 2013-11-08 19:05 JST
tags: middleman, travis-ci
---

## Middleman 静的ファイルのデプロイ

このサイトは Middleman + github.io でできていて，デプロイ時には `middleman build && middleman deploy`とします．

これはそんなに面倒じゃないんですが，↓の記事に倣って自動化させてみました．

=> [Middleman で作った web サイトを Travis + GitHub pages でお手軽に運用する](http://tricknotes.hateblo.jp/entry/2013/06/17/020229)

## 違い

で，ちょっと違う点があって工夫が必要だったので，その点だけ，残しておきます．

### gh-pages ブランチを使用していない

この点が違うところで，ブランチ構成を次のようにしています．

+ `master` # 生成された後の静的ファイル
+ `source` # 実際に作業しているブランチ

なので，source に push したら，build して，master へコミットしないといけません．

それ自体は大したことがないのですが，困るのは master に push するので，Travis さんが master のビルドをしようとしてしまいます．

ということで，master に push する際に `master` ブランチでビルドしない設定の `.travis.yml` を生成して対応することにしました．

ついでに，ビルドしたいのは `source` ブランチに push した時だけなので，`source` ブランチの `.travis.yml` にも追加．

```yaml
...略...
after_success:
  - cd build
  - echo -e "---\nbranches:\n  only:\n    - source" > .travis.yml
  - git add -A
  - git commit -m 'Update'
  - '[ $GH_TOKEN ] && git push --quiet https://$GH_TOKEN@github.com/OWNER/REPO.git 2> /dev/null'

branches:
  only:
    - source
```

### gh-pages 運用で問題が起きない理由

Travis さんは [Configuring your build#White- or blacklisting branches](http://about.travis-ci.org/docs/user/build-configuration/#White--or-blacklisting-branches) にあるように，`gh-pages` が更新された際にはビルドしないんですねー．


## 残された問題点

手動で更新した際には，`master` もビルドされてしまう．

![middleman-travis-ci](images/middleman-travis-ci.png)

対応策は，`middlemana build` で，`.travis.yml` を置くようにするか，コミットメッセージに `[ci skip]` を入れるようにするか，くらい？
