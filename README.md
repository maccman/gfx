#GFX

GFX is an 3D CSS3 animation library that extends jQuery with some useful functionality for programmatically creating CSS3 transitions. CSS3 transitions are superior to manual ones (using setTimeout) since they're hardware accelerated, something particularly noticeable on mobile devices.

GFX currently only supports WebKit browsers (Safari/Chrome). Firefox support is planned. For best results, use [WebKit Nightly](http://nightly.webkit.org/)

To see some demos, checkout [GFX's site](http://maccman.github.com/gfx/).

![GFX](https://lh4.googleusercontent.com/-LLsYFy2fsDU/TfWLdsroWuI/AAAAAAAABPY/xZSnjX2EEQQ/s640/Screen%252520shot%2525202011-06-12%252520at%25252020.58.58.png)

#Basic usage

Usage is very straightforward, simply include the `gfx.js` file in the page, along with [jQuery](http://jquery.com).

    <script src="site/jquery.js" type="text/javascript" charset="utf-8"></script>
    <script src="lib/gfx.js" type="text/javascript" charset="utf-8"></script>

Then call, `$.fn.gfx()`, passing in a set of properties and optional options.

    $("#element").gfx(properties, options)

Properties can be any CSS styles that you want to transition, such as `color`, `background` or `width`. In addition, any properties that you'd normally use with `-webkit-transform`, can be used without the `transform` prefix, such as with `scale` and `rotate` in the example below.

    $(this).gfx({
      scale: "1.5",
      rotate: "180deg"
    })

Valid options for `gfx()` are:

* `duration` - animation duration in milliseconds
* `easing` - animation flow control, either `linear`, `ease-in`, `ease-out`, `ease-in-out`, or a custom cubic bezier
* `complete` - a callback function executed after the animation has finished
* `queue` - specifies which animation queue to use, by default `fx`. Set to false to disable queuing

As with normal jQuery animations, GFX transitions can be chained so they run one after an other. Additionally, you can still use the `delay()` function.

    .gfx({
      rotate: "0deg",
      translateX: "-100px"
    }).delay(100).gfx({
      scale: "1"
    }).gfx({
      rotate: "0deg",
      translateX: "-100px"
    })

##In-built effects

GFX comes with several in built effects, but you can easily add your own. They do what they say on the tin. To seem them live checkout the [GFX website](http://maccman.github.com/gfx/).

    $.fn.gfxExplodeOut()
    $.fn.gfxExplodeIn()
    $.fn.gfxBlip()
    $.fn.gfxFadeIn()
    $.fn.gfxFadeOut()

#Transforms

GFX supports the following CSS3 transforms:

* scale
* scaleX
* scaleY
* scale3d
* rotate
* rotateX
* rotateY
* rotateZ
* rotate3d
* translate
* translateX
* translateY
* translateZ
* translate3d
* skew
* skewX
* skewY
* matrix
* matrix3d
* perspective

CSS Transforms are a whole subject to themselves, and unfortunately there isn't space to elaborate on them here. Luckily [David DeSandro](http://desandro.com/) has created a great set of tutorials, which you can find [here](http://desandro.github.com/3dtransforms/).

Additionally the WebKit blog has a great [article](http://www.webkit.org/blog/386/3d-transforms/) on transitions when they first introduced, and the [Apple Developer center](http://developer.apple.com/library/safari/#documentation/InternetWeb/Conceptual/SafariVisualEffectsProgGuide/Transforms/Transforms.html) also provides good documentation.

#Demos

More demos are planned, but feel free to contribute ideas if you coming up with a cool idea. At the moment, I'm thinking of re-creating the interfaces from Time Machine and Windows 8.