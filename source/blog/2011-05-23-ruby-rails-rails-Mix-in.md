---
title: "rails で Mix-in するときにすでにあるメソッドをオーバーライドする"
date: 2011-05-23
tags: rails
---


``` ruby 
module NewMethod
  def self.included(mod)
    mod.class_eval do
      alias_method_chain :method, :new_method
    end
  end

  def method_with_new_method
    method_without_new_method
    'new method'
  end
end

class Origin
  def method
    'origin method'
  end
  include NewMethod
end

puts Origin.new.method    #=> new method
```

include をメソッドの後に書かないといけないのが微妙

<!-- more -->

ちょっと補足

## 普通の include

``` ruby
module NewMethod
  def method
    'new method'
  end
end

class Origin
  include NewMethod
end

puts Origin.new.method          # => new method
```

## 同名メソッドがある場合
モジュールのメソッドは呼ばれない．

``` ruby
module NewMethod
  def method
    'new method'
  end
end

class Origin
  include NewMethod
  def method
    'origin method'
  end
end

puts Origin.new.method          # => origin method
```

## include の順番を変えた例
メソッドの定義順を変えても駄目．

``` ruby
module NewMethod
  def method
    'new method'
  end
end

class Origin
  def method
    'origin method'
  end
  include NewMethod
end

puts Origin.new.method          # => origin method
```

結局，include しても，最初に見つかるメソッドが呼ばれるだけ．
ということで，冒頭のコードのように method_chain を使って定義．
