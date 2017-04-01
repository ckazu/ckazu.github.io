---
title: "CSS3のみで色々な背景パターンを描画する"
date: 2011-03-21
tags: ["css3"]
---

<script type="text/javascript" src="http://jsdo.it/blogparts/hvCi/js?view=design"></script><p class="ttlBpJsdoit" style="width: 465px; margin: 0; text-align: right; font-size: 11px;"><a href="http://jsdo.it/ckazu/hvCi" title="CSS3 で作る背景パターン">CSS3 で作る背景パターン - jsdo.it - share JavaScript, HTML5 and CSS</a></p>

<!-- more -->

## gradient()

background-image に，gradient() を指定するとグラデーションを実現できます．

現状では，webkit, moz で指定方法が異なります．
webkit のほうが面倒ですね．webkit の書式は変更するとか何とか．．．

<strong class="rainbow"></strong>
<p><style>
strong.rainbow {
  display: inline-block;
  width: 300px;
  height: 40px;
  border: 1px solid #333;
  background: -moz-linear-gradient(left, red, orange, yellow, green, blue, navy, purple);
  background: -webkit-gradient(linear, left top, right top, from(red), color-stop(.14, orange), color-stop(.28, yellow), color-stop(.42, green), color-stop(.56, blue), color-stop(.68, navy), to(purple));
}
</style></p>

``` css
.rainbow {
  background-image: -moz-linear-gradient(left, red, orange, yellow, green, blue, navy, purple);
  background: -webkit-gradient(linear, left top, right top, from(red), color-stop(.14, orange), color-stop(.28, yellow), color-stop(.42, green), color-stop(.56, blue), color-stop(.68, navy), to(purple));
}
```

## rgba で透明度を指定する

rgba() を用いると透明度を設定することができます．

```
rgba(<red>, <green>, <blue>, <alphavalue>);
ただし，red, green, blue は 0-255 の値，alphavalue は 0-1 の値．
```

これを利用して，background-color で設定した色を background-image に重ねることができます．


たとえば，これらに

<strong class="block red"></strong><strong class="block green"></strong><strong class="block blue"></strong>


これを重ねると，

<strong class="block rgba-sample"></strong>

``` css
.gradation {
  background-image: -moz-linear-gradient(top, rgba( 0, 0, 0, .5), rgba(255,255,255, .5));
  background-image: -webkit-gradient(linear, left top, left bottom, from(rgba( 0, 0, 0, .5)), to(rgba(255,255,255, .5)));
}
```


こうなります．

<strong class="block rgba-sample red"></strong><strong class="block rgba-sample green"></strong><strong class="block rgba-sample blue"></strong>

最初から赤や緑のなどのグラデーションを用意しておけば良いように思えますが，半透明のグラデーションなりのスタイルを用意しておくだけで，使い回しが効くので便利です．

<p><style>
strong.block {
  display: inline-block;
  width: 40px;
  height: 40px;
  margin: 0 2px;
  border: 1px solid #333;
}
strong.rgba-sample { background-image: -moz-linear-gradient(top, rgba( 0, 0, 0, .5), rgba(255,255,255, .5)); }
strong.rgba-sample { background-image: -webkit-gradient(linear, left top, left bottom, from(rgba( 0, 0, 0, .5)), to(rgba(255,255,255, .5))); }

strong.red { background-color: red; }
strong.green { background-color: green; }
strong.blue { background-color: blue; }
</style></p>


## 複数のパターンを重ねる

CSS3 では，background-image には，複数の画像を指定できるようになりました．

``` css
  background-image: url(a.png), url(b.png), url(c.png)
```

ここには，もちろん gradient() も指定できます．


たとえば，次の3種類のグラデーションを，

<strong class="l-block g-red"></strong><strong class="l-block g-green"></strong><strong class="l-block g-blue"></strong>

``` css
.red {
  background-image: -moz-linear-gradient(top left,  rgba(255,  0,  0, .5), rgba(255,255,255,.1));
  background-image: -webkit-gradient(linear, left top, right top, from(rgba(255,  0,  0, .5)), to(rgba(255,255,255,.1)));
}
.green {
  background-image: -moz-linear-gradient(top right, rgba(  0,255,  0, .5), rgba(255,255,255,.1));
  background-image: -webkit-gradient(linear, right top, left top, from(rgba(  0,255,  0, .5)), to(rgba(255,255,255,.1)));
}
.blue  {
  background-image: -moz-linear-gradient(top, rgba(  0,  0,255, .5), rgba(255,255,255,.1));
  background-image: -webkit-gradient(linear, left top, left bottom, from(rgba(  0,  0,255, .5)), to(rgba(255,255,255,.1)));
}
```


すべて混ぜると，次のようになります．

すべてのグラデーションが混ざっているのが分かるでしょうか．

<strong class="l-block multi-gradient"></strong>

``` css
.mixes {
  background-image:
    -moz-linear-gradient(top left, rgba(255,  0,  0, .5), rgba(255,255,255,.1)),
    -moz-linear-gradient(top right, rgba(  0,255,  0, .5), rgba(255,255,255,.1)),
    -moz-linear-gradient(top, rgba(  0,  0,255, .5), rgba(255,255,255,.1));
  background-image:
    -webkit-gradient(linear, left top, right top, from(rgba(255,  0,  0, .5)), to(rgba(255,255,255,.1))),
    -webkit-gradient(linear, right top, left top, from(rgba(  0,255,  0, .5)), to(rgba(255,255,255,.1))),
    -webkit-gradient(linear, left top, left bottom, from(rgba(  0,  0,255, .5)), to(rgba(255,255,255,.1)));
}
```

<p><style>
strong.l-block {
  display: inline-block;
  width: 200px;
  height: 40px;
  margin: 0 2px;
  border: 1px solid #333;
}
strong.g-red   {
  background-image: -moz-linear-gradient(top left,  rgba(255,  0,  0, .5), rgba(255,255,255,.1));
  background-image: -webkit-gradient(linear, left top, right top, from(rgba(255,  0,  0, .5)), to(rgba(255,255,255,.1)));
}
strong.g-green {
  background-image: -moz-linear-gradient(top right, rgba(  0,255,  0, .5), rgba(255,255,255,.1));
  background-image: -webkit-gradient(linear, right top, left top, from(rgba(  0,255,  0, .5)), to(rgba(255,255,255,.1)));
}
strong.g-blue  {
  background-image: -moz-linear-gradient(top, rgba(  0,  0,255, .5), rgba(255,255,255,.1));
  background-image: -webkit-gradient(linear, left top, left bottom, from(rgba(  0,  0,255, .5)), to(rgba(255,255,255,.1)));
}
strong.multi-gradient {
  background-image: -moz-linear-gradient(top left,  rgba(255,  0,  0, .5), rgba(255,255,255,.1)),
                    -moz-linear-gradient(top right, rgba(  0,255,  0, .5), rgba(255,255,255,.1)),
                    -moz-linear-gradient(top,       rgba(  0,  0,255, .5), rgba(255,255,255,.1));
  background-image: -webkit-gradient(linear, left top, right top, from(rgba(255,  0,  0, .5)), to(rgba(255,255,255,.1))),
                                  -webkit-gradient(linear, right top, left top, from(rgba(  0,255,  0, .5)), to(rgba(255,255,255,.1))),
                                  -webkit-gradient(linear, left top, left bottom, from(rgba(  0,  0,255, .5)), to(rgba(255,255,255,.1)));
}
</style></p>


## gradient() でストライプを作る

また，gradient の指定を工夫すると，このようなパターンを作ることができます．

<strong class="block sample-stripe"></strong>

``` css
.stripe {
  background-image: -moz-linear-gradient(left, transparent, transparent 50%, rgba(0,0,0,.5) 50%, rgba(0,0,0,.5) 100%);
  background-image: -webkit-gradient(linear, left top, right top, from(transparent), color-stop(.5, transparent), color-stop(.5, rgba(0,0,0,.5)), to(rgba(0,0,0,.5)));
}
```


これに加えて，background-size を指定すると，次のような効果が得られます．

### background-size: 2px;

<strong class="l-block sample-stripe bgsize2"></strong>

``` css
  -moz-background-size: 2px 2px;
  -webkit-background-size: 2px 2px;
  background-size: 2px 2px;
```

### background-size: 5px;

<strong class="l-block sample-stripe bgsize5"></strong>

``` css
  -moz-background-size: 5px 5px;
  -webkit-background-size: 5px 5px;
  background-size: 5px 5px;
```

### background-size: 20px;

<strong class="l-block sample-stripe bgsize20"></strong>

``` css
  -moz-background-size: 20px 20px;
  -webkit-background-size: 20px 20px;
  background-size: 20px 20px;
```

<p><style>
strong.sample-stripe {
  background-image: -moz-linear-gradient(left, transparent, transparent 50%, rgba(0,0,0,.5) 50%, rgba(0,0,0,.5) 100%);
  background-image: -webkit-gradient(linear, left top, right top, from(transparent), color-stop(.5, transparent), color-stop(.5, rgba(0,0,0,.5)), to(rgba(0,0,0,.5)));
}
strong.bgsize2 {
  -moz-background-size: 2px 2px;
  -webkit-background-size: 2px 2px;
  background-size: 2px 2px;
}
strong.bgsize5 {
  -moz-background-size: 5px 5px;
  -webkit-background-size: 5px 5px;
  background-size: 5px 5px;
}
strong.bgsize20 {
  -moz-background-size: 20px 20px;
  -webkit-background-size: 20px 20px;
  background-size: 20px 20px;
}
</style></p>


## 組み合わせる

これまでの要領でごにょごにょすれば，よく見かける次のような効果を作り出すことができます．
あとは，角度をつけたり，組み合わせたりするだけなので，基本的なところができてしまえば比較的簡単にできます．

<strong class="button stripe">stripe</strong><strong class="button slash">slash</strong><strong class="button check">check</strong><strong class="button dot">dot</strong>


詳しいコードは，[jsdo.it](http://jsdo.it/ckazu/hvCi) で確認してみてください．

<p><style>
strong.button {
  display: inline-block;
  margin: 4px;
  padding: 2px 0.5em;
  min-width: 75px;
  color: white;
  background-color: #ccc;

  font: normal italic 1em/2em sans-serif;
  text-align: center;
  text-shadow: 1px 1px 2px #000;

  border: 1px solid #333;
  position: relative;
  
  -webkit-box-shadow: 0  1px  1px #fff inset,
                      0 -2px  2px rgba( 0, 0, 0, .3) inset,
                      1px 1px 2px #333;
  -moz-box-shadow: 0  1px  1px #fff inset,
                   0 -2px  2px rgba( 0, 0, 0, .3) inset,
                   1px 1px 2px #333;

  transition: background-color .5s ease, color .5s ease;
  -webkit-transition: background-color .5s ease, color .5s ease;
  -moz-transition: background-color .5s ease, color .5s ease;
}
strong.stripe {
  background-image: -webkit-gradient(
                      linear,
                      left top,
                      left bottom,
                      from(rgba(255,255,255, .1)),
                      color-stop(.5, rgba(255,255,255, .1)),
                      color-stop(.5, rgba(  0,  0,  0, .1)),
                      to(rgba( 0, 0, 0, .1)));
  background-image: -moz-linear-gradient(
                      top,
                      rgba(255,255,255, .1)   0,
                      rgba(255,255,255, .1)  50%,
                      rgba(  0,  0,  0, .1)  50%,
                      rgba(  0,  0,  0, .1) 100%);
  background-size: 16px;
  -webkit-background-size: 16px;
  -moz-background-size: 16px;
}
strong.slash {
  background-color: #c99;
  background-image: -webkit-gradient(
                      linear,
                      left top,
                      right bottom,
                      from(           rgba(  0,  0,  0, .1)),
                      color-stop(.05, rgba(  0,  0,  0, .1)),
                      color-stop(.05, rgba(255,255,255, .1)),
                      color-stop(.45, rgba(255,255,255, .1)),
                      color-stop(.45, rgba(  0,  0,  0, .1)),
                      color-stop(.55, rgba(  0,  0,  0, .1)),
                      color-stop(.55, rgba(255,255,255, .1)),
                      color-stop(.95, rgba(255,255,255, .1)),
                      color-stop(.95, rgba(  0,  0,  0, .1)),
                      to(             rgba(  0,  0,  0, .1)));

  background-image: -moz-linear-gradient(
                      -45deg,
                      rgba(  0,  0,  0, .1)  0,
                      rgba(  0,  0,  0, .1)   5%,
                      rgba(255,255,255, .1)   5%,
                      rgba(255,255,255, .1)  45%,
                      rgba(  0,  0,  0, .1)  45%,
                      rgba(  0,  0,  0, .1)  55%,
                      rgba(255,255,255, .1)  55%,
                      rgba(255,255,255, .1)  95%,
                      rgba(  0,  0,  0, .1)  95%,
                      rgba(  0,  0,  0, .1) 100%);
  background-size: 5px 5px;
  -webkit-background-size: 5px 5px;
  -moz-background-size: 5px 5px;
}
strong.check {
  background-color: #9c9;
  background-image: -webkit-gradient(
                      linear,
                      left top,
                      left bottom,
                      from(rgba(255,255,255, .1)),
                      color-stop(.5, rgba(255,255,255, .1)),
                      color-stop(.5, rgba(  0,  0,  0, .1)),
                      to(rgba( 0, 0, 0, .1))),
                   -webkit-gradient(
                      linear,
                      left top,
                      right top,
                      from(rgba(255,255,255, .1)),
                      color-stop(.5, rgba(255,255,255, .1)),
                      color-stop(.5, rgba(  0,  0,  0, .1)),
                      to(rgba( 0, 0, 0, .1)));
  background-image: -moz-linear-gradient(
                      top,
                      rgba(255,255,255, .1)   0,
                      rgba(255,255,255, .1)  50%,
                      rgba(  0,  0,  0, .1)  50%,
                      rgba(  0,  0,  0, .1) 100%),
                    -moz-linear-gradient(
                      left,
                      rgba(255,255,255, .1)   0,
                      rgba(255,255,255, .1)  50%,
                      rgba(  0,  0,  0, .1)  50%,
                      rgba(  0,  0,  0, .1) 100%);
  background-size: 8px 8px;
  -webkit-background-size: 8px 8px;
  -moz-background-size: 8px 8px;
}

strong.dot {
  background-color: #99c;
  background-image: -webkit-gradient(
                      radial,
                      center center, 0,
                      center center, 3,
                      from(rgba(255,255,255, .1)),
                      color-stop(.75, rgba(255,255,255, .1)),
                      to(rgba( 0, 0, 0, .1)));
  background-image: -moz-radial-gradient(
                      center,
                      circle closest-side,
                      rgba(255,255,255, .1),
                      rgba(255,255,255, .1) 50%,
                      rgba( 0, 0, 0, .1) 50%,
                      rgba( 0, 0, 0, .1));
  background-size: 10px 10px;
  -webkit-background-size: 10px 10px;
  -moz-background-size: 10px 10px;
}
</style></p>
