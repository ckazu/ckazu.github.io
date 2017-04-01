---
title: "CSS3で水滴のような形を描く"
date: 2011-03-19
tags: ["css3"]
---


CSS3 面白いですね．

今までは思いつかなかったようなことができるようになっています．

その CSS3 を使って，次のような水滴（のようなもの）を CSS だけで作ってみます．

<script type="text/javascript" src="http://jsdo.it/blogparts/cSGk/js"></script>

なお，動作確認は，chrome, firefox でしか行っていませんので，あしからず．

IE での動作は全く保証しません．

<!-- more -->


## border-radius を使って円を描く

一般的には角丸を実現するための border-radius ですが，目一杯のサイズを指定すると，円を描画することができます．

<strong class="circle"></strong>

``` html
<p class="circle">円</p>
```

``` css
.circle {
  width: 40px;
  height: 40px;
  background: #ccf;
  border: 1px solid #99f;

  border-radius: 50%;
  -moz-border-radius: 50%;
  -webkit-border-radius: 50%;
}
```


## border-radius でそれぞれの角の半径を指定する

border-radius は4つの角のそれぞれの角の半径を指定でき，また，楕円としてその長半径，短半径を指定することができます．

<strong class="ellipse"></strong>

``` html
<p class="ellipse">楕円</p>
```

``` css
  .ellipse {
    width: 60px;
    height: 40px;
    border: 1px solid #33f;
    background: #ccf;

    border-radius: 20px / 30px;
    -moz-border-radius: 20px / 30px;
    -webkit-border-radius: 20px / 30px;
  }
```


<strong class="rounded"></strong>

``` html
<p class="rounded">曲面</p>
```

``` css
  .rounded {
    width: 40px;
    height: 40px;
    border: 1px solid #33f;
    background: #ccf;

    border-radius: 20px 5px 1px 50px / 5px 5px 1px 20px;
    -moz-border-radius: 20px 5px 1px 40px / 5px 5px 1px 20px;
    -webkit-border-radius: 20px 5px 1px 40px / 5px 5px 1px 20px;
  }
```


指定方法，対応状況などは以下を参考に．

* cite: [http://www.w3.org/TR/css3-background/#the-border-radius](http://www.w3.org/TR/css3-background/#the-border-radius)
* cite: [https://developer.mozilla.org/en/CSS/border-radius](https://developer.mozilla.org/en/CSS/border-radius)


## 水滴っぽい形を作る

さて，水滴の形を表現するには，上部を上に引っ張った形を作る必要がありますが，border-radius では，上下左右の角を丸めることしかできません．

そこで，とりあえず，左上を除いた3つの角を丸め，左上にとんがった形を作ります．

<strong class="pre-drop-shape"></strong>

``` html
<p class="pre-drop-shape">水滴っぽい形</p>
```
``` css
  .pre-drop-shape {
    width: 40px;
    height: 40px;
    border: 1px solid #33f;
    background: #ccf;

    border-radius: 10% 50% 50% 50%;
    -moz-border-radius: 10% 50% 50% 50%;
    -webkit-border-radius: 10% 50% 50% 50%;
  }
```

## 傾ける

とりあえず，左上がとんがった形を作ることができました．

これを，transform を使用し45度傾けて，左上が真上になるように回転させます．

<strong class="drop-shape"></strong>

``` html
<p class="drop-shape">水滴っぽい形</p>
```
``` css
  .drop-shape {
    width: 40px;
    height: 40px;
    background: #ccf;
    border: 1px solid #33f;

    border-radius: 10% 50% 50% 50%;
    transform: rotate(45deg);

    -moz-border-radius: 10% 50% 50% 50%;
    -moz-transform: rotate(45deg);

    -webkit-border-radius: 10% 50% 50% 50%;
    -webkit-transform: rotate(45deg);
  }
```


## グラデーションなどを施す

box-shadow や background に linear-gradient などを使い，それっぽく仕上げます（適当）．

<strong class="drop"></strong>

``` html
<p class="drop">水滴?</p>
```
``` css
  .drop {
    width: 30px;
    height: 30px;
    border: 1px solid #ccc;

    background: linear-gradient(top left, rgba(255,255,255,.5), rgba(0,0,0, .75) 100%), #39f;
    border-radius: 10% 50% 50% 50%;
    box-shadow: inset 2px -2px 3px #fff, inset -1px 1px 1px rgba(255,255,255, .2);
    transform: rotate(45deg);

    background: -moz-linear-gradient(top left, rgba(255,255,255,.5), rgba(0,0,0, .75) 100%), #39f;
    -moz-border-radius: 10% 50% 50% 50%;
    -moz-box-shadow: inset 2px -2px 3px #fff, inset -1px 1px 1px rgba(255,255,255, .2);
    -moz-transform: rotate(45deg);

    background: -webkit-linear-gradient(top left, rgba(255,255,255,.5), rgba(0,0,0, .75) 100%), #39f;
    -webkit-border-radius: 10% 50% 50% 50%;
    -webkit-box-shadow: inset 2px -2px 3px #fff, inset -1px 1px 1px rgba(255,255,255, .2);
    -webkit-transform: rotate(45deg);
  }
```

## :hover, transition でちょっとしたアニメーションをさせる

ちょっと手を加えると，ナビゲーションなどに使えるかもしれません．

※ firefox3 では transition が動作しません．

<strong class="list-drop black"></strong><strong class="list-drop white"></strong><strong class="list-drop red"></strong><strong class="list-drop green"></strong><strong class="list-drop blue"></strong>

``` html
<ul>
<li class="drop black">black</li>
<li class="drop white">white</li>
<li class="drop red">red</li>
<li class="drop green">green</li>
<li class="drop blue">blue</li>
</il>
```
``` css
  .drop {
    width: 30px;
    height: 30px;
    margin: 4px;
    display: inline-block;
    background: -moz-linear-gradient(top left, rgba(255,255,255,.5), rgba(0,0,0, .75) 100%), #39f;
    background: -webkit-linear-gradient(top left, rgba(255,255,255,.5), rgba(0,0,0, .75) 100%), #39f;
    border: 1px solid #ccc;
    position: relative;

    border-radius: 50%;
    box-shadow: inset 2px -2px 3px #fff, inset -1px 1px 1px rgba(255,255,255, .2), 2px 0 2px rgba(0,0,0,.3);
    transform: rotate(45deg);
    transition: all linear .1s;

    -moz-border-radius: 50%;
    -moz-box-shadow: inset 2px -2px 3px #fff, inset -1px 1px 1px rgba(255,255,255, .2), 2px 0 2px rgba(0,0,0,.3);
    -moz-transform: rotate(45deg);
    -moz-transition: all linear .1s;

    -webkit-border-radius: 50%;
    -webkit-box-shadow: inset 2px -2px 3px #fff, inset -1px 1px 1px rgba(255,255,255, .2), 2px 0 2px rgba(0,0,0,.3);
    -webkit-transform: rotate(45deg);
    -webkit-transition: all linear .1s;
  }
  .drop:hover {
    top: 3px;
    border-radius: 10% 50% 50% 50%;
    -moz-border-radius: 10% 50% 50% 50%;
    -webkit-border-radius: 10% 50% 50% 50%;
  }

  .black { background-color: #666; border-color: #999; }
  .white { background-color: #ccc; border-color: #999; }
  .red   { background-color: #c00; border-color: #900; }
  .green { background-color: #0c0; border-color: #090; }
  .blue  { background-color: #00c; border-color: #009; }
```

<p><style>
  strong.circle {
    width: 40px;
    height: 40px;
    border: 1px solid #33f;
    border-radius: 50%;
    -moz-border-radius: 50%;
    display: block;
    background: #ccf;
  }

  strong.rounded {
    width: 40px;
    height: 40px;
    border: 1px solid #33f;
    border-radius: 20px 5px 1px 40px / 5px 5px 1px 20px;
    -moz-border-radius: 20px 5px 1px 40px / 5px 5px 1px 20px;
    display: block;
    background: #ccf;
  }

  strong.ellipse {
    width: 60px;
    height: 40px;
    border: 1px solid #33f;
    border-radius: 30px/20px;
    -moz-border-radius: 30px/20px;
    display: block;
    background: #ccf;
  }

  strong.pre-drop-shape {
    width: 30px;
    height: 30px;
    border: 1px solid #33f;
    border-radius: 10% 50% 50% 50%;
    -moz-border-radius: 10% 50% 50% 50%;
    display: block;
    background: #ccf;
  }

  strong.drop-shape {
    width: 30px;
    height: 30px;
    border: 1px solid #33f;
    border-radius: 10% 50% 50% 50%;
    -moz-border-radius: 10% 50% 50% 50%;
    transform: rotate(45deg);
    -moz-transform: rotate(45deg);
    -webkit-transform: rotate(45deg);
    display: block;
    background: #ccf;
  }

  strong.drop {
    width: 30px;
    height: 30px;
    margin: 4px;
    display: inline-block;
    background: -moz-linear-gradient(top left, rgba(255,255,255,.5), rgba(0,0,0, .75) 100%), #39f;
    background: -webkit-linear-gradient(top left, rgba(255,255,255,.5), rgba(0,0,0, .75) 100%), #39f;
    border: 1px solid #ccc;

    border-radius: 10% 50% 50% 50%;
    box-shadow: inset 2px -2px 3px #fff, inset -1px 1px 1px rgba(255,255,255, .2);
    transform: rotate(45deg);

    -moz-border-radius: 10% 50% 50% 50%;
    -moz-box-shadow: inset 2px -2px 3px #fff, inset -1px 1px 1px rgba(255,255,255, .2);
    -moz-transform: rotate(45deg);

    -webkit-border-radius: 10% 50% 50% 50%;
    -webkit-box-shadow: inset 2px -2px 3px #fff, inset -1px 1px 1px rgba(255,255,255, .2);
    -webkit-transform: rotate(45deg);
  }

  strong.list-drop {
    width: 30px;
    height: 30px;
    margin: 4px;
    display: inline-block;
    background: -moz-linear-gradient(top left, rgba(255,255,255,.5), rgba(0,0,0, .75) 100%), #39f;
    background: -webkit-linear-gradient(top left, rgba(255,255,255,.5), rgba(0,0,0, .75) 100%), #39f;
    border: 1px solid #ccc;
    position: relative;

    border-radius: 50%;
    box-shadow: inset 2px -2px 3px #fff, inset -1px 1px 1px rgba(255,255,255, .2), 2px 0 2px rgba(0,0,0,.3);
    transform: rotate(45deg);
    transition: all linear .1s;

    -moz-border-radius: 50%;
    -moz-box-shadow: inset 2px -2px 3px #fff, inset -1px 1px 1px rgba(255,255,255, .2), 2px 0 2px rgba(0,0,0,.3);
    -moz-transform: rotate(45deg);
    -moz-transition: all linear .1s;

    -webkit-border-radius: 50%;
    -webkit-box-shadow: inset 2px -2px 3px #fff, inset -1px 1px 1px rgba(255,255,255, .2), 2px 0 2px rgba(0,0,0,.3);
    -webkit-transform: rotate(45deg);
    -webkit-transition: all linear .1s;
  }
  strong.list-drop:hover {
    top: 3px;

    border-radius: 10% 50% 50% 50%;
    -moz-border-radius: 10% 50% 50% 50%;
    -webkit-border-radius: 10% 50% 50% 50%;
  }

  strong.black { background-color: #666; border-color: #999; }
  strong.white { background-color: #ccc; border-color: #999; }
  strong.red   { background-color: #c00; border-color: #900; }
  strong.green { background-color: #0c0; border-color: #090; }
  strong.blue  { background-color: #00c; border-color: #009; }
</style></p>
