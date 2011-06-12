$ = jQuery

sides =
  front:  {rotateY: '0deg',    rotateX: '0deg'}
  back:   {rotateX: '-180deg', rotateX: '0deg'}
  right:  {rotateY: '-90deg',  rotateX: '0deg'}
  left:   {rotateY: '90deg',   rotateX: '0deg'}
  top:    {rotateY: '0deg',    rotateX: '-90deg'}
  bottom: {rotateY: '0deg',    rotateX: '90deg'}

$.fn.gfxCube = (options = {}) ->
  element = $(@)
  front   = element.find('.front')
  back    = element.find('.back')
  right   = element.find('.right')
  left    = element.find('.left')
  top     = element.find('.top')
  bottom  = element.find('.bottom')
  
  element.css
    position: 'relative'
    width: 300
    height: 300
    
  element.children().css
    display: 'block'
    position: 'absolute'
    width: '100%'
    height: '100%'
    
  tZ = options.translateZ or 300 / 2
  tZ += 'px' if typeof tZ is 'number'
  
  front.transform   rotateY: '0deg',   'translateZ': tZ
  back.transform    rotateY: '180deg', 'translateZ': tZ
  right.transform   rotateY: '90deg',  'translateZ': tZ
  left.transform    rotateY: '-90deg', 'translateZ': tZ
  top.transform     rotateX: '90deg',  'translateZ': tZ
  bottom.transform  rotateX: '-90deg', 'translateZ': tZ
  
  $(@).bind 'cube', (e, type) ->
    $(@).gfx($.extend({}, sides[type]), options)

$.fn.gxfxCubeIn = (options = {}) ->
  $(@).queueNext ->
    $(@).transform(rotateY: '90deg', display: 'block')
  $(@).gfx({rotateY: 0}, options)
  
$.fn.gxfxCubeOut = (options = {}) ->
  $(@).css
    '-webkit-backface-visibility': 'hidden'
  $(@).gfx({rotateY: '-90deg'}, options)
  $(@).queueNext ->
    $(@).transform(rotateY: 0, display: 'none')
  