$ = jQuery

sides =
  front:  {rotateY: '0deg',    rotateX: '0deg'}
  back:   {rotateX: '-180deg', rotateX: '0deg'}
  right:  {rotateY: '-90deg',  rotateX: '0deg'}
  left:   {rotateY: '90deg',   rotateX: '0deg'}
  top:    {rotateY: '0deg',    rotateX: '-90deg'}
  bottom: {rotateY: '0deg',    rotateX: '90deg'}

defaults = 
  width: 300
  height: 300

$.fn.gfxCube = (options) ->
  opts = $.extend({}, defaults, options)
  
  element = $(@)
  
  tZ = opts.translateZ or opts.width / 2
  tZ += 'px' if typeof tZ is 'number'
  
  element.transform
    position: 'relative'
    width:  opts.width
    height: opts.height
    '-webkit-perspective': '3000'
    '-moz-perspective': '3000'
    '-webkit-perspective-origin': '50% 50%'
    '-moz-perspective-origin': '50% 50%'
    
  wrapper = $('<div />')
  wrapper.addClass('gfxCubeWrapper')
  wrapper.transform
    position: 'absolute'
    width: '100%'
    height: '100%'
    left: 0
    top: 0
    overflow: 'visible'
    rotateY: '0deg'
    rotateX: '0deg'
    translateZ: "-#{tZ}"
    '-webkit-transform-style': 'preserve-3d'
    '-moz-transform-style': 'preserve-3d'
    '-webkit-transform-origin': '50% 50%'    
    '-moz-transform-origin': '50% 50%'    
    
  element.children().wrapAll(wrapper).css
    display: 'block'
    position: 'absolute'
    width: '100%'
    height: '100%'
    left: 0
    top: 0
    overflow: 'hidden'
    
  front   = element.find('.front')
  back    = element.find('.back')
  right   = element.find('.right')
  left    = element.find('.left')
  top     = element.find('.top')
  bottom  = element.find('.bottom')
  
  front.transform   rotateY: '0deg',   translateZ: tZ
  back.transform    rotateY: '180deg', translateZ: tZ
  right.transform   rotateY: '90deg',  translateZ: tZ
  left.transform    rotateY: '-90deg', translateZ: tZ
  top.transform     rotateX: '90deg',  translateZ: tZ
  bottom.transform  rotateX: '-90deg', translateZ: tZ
  
  $(@).bind 'cube', (e, type) ->
    wrapper = element.find('.gfxCubeWrapper')
    wrapper.gfx($.extend({}, {translateZ: "-#{tZ}"}, sides[type]))
    
# Disable cubes in Firefox / Chrome < 12
chromeRegex = /(Chrome)[\/]([\w.]+)/
chromeMatch = chromeRegex.exec( navigator.userAgent ) or []
chrome11    = chromeRegex[1] and chromeRegex[2].test(/^12\./)

if not $.browser.webkit or chrome11
  $.fn.gfxCube = (options) ->
    opts = $.extend({}, defaults, options)
    
    element = $(@)
    
    element.css
      position: 'relative'
      width:  opts.width
      height: opts.height
      
    wrapper = $('<div />')
    wrapper.addClass('gfxCubeWrapper')
    wrapper.transform
      position: 'absolute'
      width: '100%'
      height: '100%'
      left: 0
      top: 0
      overflow: 'visible'

    element.children().wrapAll(wrapper).css
      display: 'block'
      position: 'absolute'
      width: '100%'
      height: '100%'
      left: 0
      top: 0
      overflow: 'hidden'

    wrapper = element.find('.gfxCubeWrapper')
    
    wrapper.children('*:not(.front)').hide()
    element.bind 'cube', (e, type) ->
      wrapper.children().hide()
      wrapper.children(".#{type}").show()