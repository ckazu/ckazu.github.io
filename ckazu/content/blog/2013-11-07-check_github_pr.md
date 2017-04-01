---
title: GitHub で open になっている PR をチェックする
date: 2013-11-07T14:18:00+09:00
tags: ["github"]
---

## API を叩く

複数の GitHub リポジトリの PR をチェックするのが割りと面倒なので，日時バッチで通知するようにしている．

PR を取得するには，[GitHub Developer API](http://developer.github.com/v3/pulls/#list-pull-requests) を叩けば済む．

```sh
$ curl https://api.github.com/repos/rails/rails/pulls
```

以下の様に JSON でまるっと返ってくるので，必要に応じて欲しい情報を取得する．

```json
[
  {
    "url": "https://api.github.com/repos/rails/rails/pulls/12791",
    "id": 9743099,
    "html_url": "https://github.com/rails/rails/pull/12791",
    "diff_url": "https://github.com/rails/rails/pull/12791.diff",
    "patch_url": "https://github.com/rails/rails/pull/12791.patch",
    "issue_url": "https://github.com/rails/rails/pull/12791",
    "number": 12791,
    "state": "open",
    "title": "add autoload :TransactionState to fix Marshal.load issues",
    "user": {
      "login": "jasonayre",
      "id": 155084,
      "avatar_url": "https://2.gravatar.com/avatar/3d4ea18be907fb6130be9749ec336cd6?d=https%3A%2F%2Fidenticons.github.com%2Faf5a6968d0d85aa4ea4af86409d642a0.png&r=x",
...以下略...
```

## private repository

ただし，private なリポジトリの場合には認証が必要．

[https://github.com/settings/applications](https://github.com/settings/applications) から，`Personal Access Token`を発行して使用する．

```sh
$ curl -u USERNAME:ACCESSTOKEN https://api.github.com/repos/OWNER/REPO/pulls
```

## ruby で書いたものはこちらに．

=> [ckazu/github_checker](https://github.com/ckazu/github_checker)
