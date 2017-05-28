---
title: rails の delegate で，移譲先のオブジェクトが nil になる場合の対応
date: 2013-12-14T00:00:00+09:00
tags: ["rails"]
---

## delegate

互いに関連を持つ`User`, `Profile` があるとして，ある`User`を主体として`Profile#job`を得るには`user.profile.job`とする必要があります．

ですが，単に`user.job`とアクセスしたいと思うこともあるでしょう．

```ruby
class User < ActiveRecord::Base
  belongs_to :profile

  def job
    profile.try(:job)
  end
end
```

ということで，`User#job`メソッドを定義しました．

しかし，この場合は，次のように移譲を用いることで解決することができます．

```ruby
class User < ActiveRecord::Base
  belongs_to :profile
  delegate :job, to: :profile
end
```

## 移譲先が nil のケース

ただ，`user.profile`が存在しない場合(`user.profile==nil`の場合)，`NoMethodError`になりますね．

移譲先のオブジェクトにアクセス可能であることが保証できない場合，`allow_nil`オプションを指定することでこれを解決できます．

```ruby
class User < ActiveRecord::Base
  belongs_to :profile
  delegate :job, to: :profile, allow_nil: true
end
```
