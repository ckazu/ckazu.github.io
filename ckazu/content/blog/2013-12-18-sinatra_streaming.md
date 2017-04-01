---
title: Sinatra で streaming を使用した際にちゃんとコネクションを閉じる
date: 2013-12-18T22:14:00+09:00
tags: ["sinatra"]
---

## Sinatra で Streaming

Sinatra で WebSocket のような stream の簡便な実装を書くことができます．

簡易なチャットシステムや，流れてくるログ拾ってきてブラウザで眺めるなどの用途に使えそうです．

```ruby
  get '/', provides: 'text/event-stream' do
    stream :keep_open do |conn|
      conn << 'なにがしかの処理'
      sleep 1
    end
  end
```

## loop したい

たとえば，ログを眺めるような用途だと，ログを監視して差分を送ってあげるなどの処理が必要になるでしょう．

loop ブロックを使用したくなることがありそうです．
              
```ruby
    stream :keep_open do |conn|
      loop do
        conn << 'データの差分を送る'
        sleep 1
      end
    end
```

## connection が増幅する

しかし，この実装だと，ブラウザをリロードしてみると以前のコネクションが残ってしまいます．

次のようにしてサーバログを見ると，リロードした数だけ余分に呼ばれていることがわかります．

```ruby
    stream :keep_open do |conn|
      loop do
        p 'loop'
        conn << 'データの差分を送る'
        sleep 1
      end
    end
```

## callback 

connection が切れたことを検知するには，callback を利用するのが良さそうです．
                
```ruby
    stream :keep_open do |conn|
      loop do
        conn << 'データの差分を送る'
        conn.errback { p 'closed' }
        sleep 1
      end
    end
```

## コネクションの管理

ただし，callback の Proc 内では loop ブロックを break できないので，次のようにしてコネクションを管理することにします．

```ruby
  get '/', provides: 'text/event-stream' do
    conns = []
    stream :keep_open do |conn|
      conns << conn
      loop do
        conn << 'データの差分を送る'

        # if connection closed
        conn.callback { conns.delete conn }
        conn.errback { conns.delete conn }
        break unless conns.include? conn

        sleep 1
      end
    end
  end 
```
