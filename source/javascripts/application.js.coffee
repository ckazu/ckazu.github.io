#= require 'modernizr/modernizr'
#= require 'jquery'
#= require_tree ./vendor
#= require_tree ./lib
$('.tweet').socialbutton('twitter', {button: 'horizontal'});
$('.facebook_like').socialbutton('facebook_like');
$('.hatena').socialbutton('hatena');
$('.evernote').socialbutton('evernote');
