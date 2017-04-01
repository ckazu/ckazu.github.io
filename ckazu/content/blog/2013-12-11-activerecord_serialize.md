---
title: ActiveRecord の serialize を使う
date: 2013-12-11T23:06:00+09:00
tags: ["rails"]
---

## ActiveRecord::Base .serialize

rails でオブジェクトをそのまま DB に保存したい場合， serialize が使える場合があります．

```ruby
class User < ActiveRecord::Base
  serialize :group_ids
end
```

このようにすると，`User#group_ids` オブジェクトは serialize されて保存されますが，扱う際にはそれを意識する必要がありません．

```ruby
> User.create(name: 'alice', group_ids: [1,2,3])
> User.save
```

DB には，YAML 形式で保存されています．

```
> select * from users;
1|alice|---\n- 1\n- 3\n- 5|2013-12-11 14:18:07.344781|2013-12-11 14:18:07.344781
```

rails では，保存した時のオブジェクトとしてきちんと取り扱われます．

```ruby
> user = User.find(1)
  User Load (0.3ms)  SELECT "users".* FROM "users" WHERE "users"."id" = ? LIMIT 1  [["id", 1]]
=> #<User id: 1, name: "alice", group_ids: [1, 3, 5], created_at: "2013-12-11 14:18:07", updated_at: "2013-12-11 14:18:07">
> user.group_ids
=> [1, 3, 5]
> user.group_ids.class
=> Array
```

## オブジェクトの種類の制限

また，`.serialize` の第二引数にオブジェクトのクラスを指定すると，保存するオブジェクトの種類を制限できます．

```ruby
class User < ActiveRecord::Base
  serialize :group_ids, Array
end
```

```ruby
> User.create(name: 'bob', group_ids: '1,2,3')
   (0.1ms)  begin transaction
   (0.1ms)  rollback transactionActiveRecord::SerializationTypeMismatch: Attribute was supposed to be a Array, but was a String. -- "1,2,3"
```

オブジェクトが異なる場合，例外`ActiveRecord::SerializationTypeMismatch`を送出します．

## テスト

```ruby
class User < ActiveRecord::Base
  serialize :group_ids, Array
end
```

この場合，`Array`を保証する`serialize`のテストはどう書くのが良いのでしょうか．

スタンダードな方法がわからなかったので，愚直に書いてみました．

```ruby
describe '.serialize' do
  let(:user) { build :user }

  context 'when group_ids given the Array object' do
    subject { user.group_ids }
    before do
      user.group_ids = [1, 3, 5]
      user.save
    end
    it { should match_array [1,3,5] }
  end

  context 'when group_ids given an invalid object' do
    [12345, 'string value', {key: 'value'}].each do |invalid_object|
      before { user.group_ids = invalid_object }
      it { expect { user.save }.to raise_error(ActiveRecord::SerializationTypeMismatch) }
    end
  end
end
```

`shoulda-matchers`のように宣言的に書けるものはあるのでしょうか．

### はまった点

オブジェクトが異なる場合に，例外`ActiveRecord::SerializationTypeMismatch`が送出されるのは，保存の時ですね．

なので，たとえば，`Array`を期待しているカラムに対して

```ruby
> user.group_ids = 'invalid value'
=> "invalid value"
> user
=> #<User id: 2, name: "bob", group_ids: "invalid value", created_at: "2013-12-11 14:25:27", updated_at: "2013-12-11 14:25:27">
```

などとしても，この時点では何の問題も起きません．
