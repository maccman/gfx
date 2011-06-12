$ = jQuery

sides: 
  front:  {rotateY: '0deg'}
  back:   {rotateX: '-180deg'}
  right:  {rotateY: '-90deg'}
  left:   {rotateY: '90deg'}
  top:    {rotateX: '-90deg'}
  bottom: {rotateX: '90deg'}

$.fn.gfxCube = (options = {}) ->
  element = $(@)
  front   = element.find('.front')
  back    = element.find('.back')
  right   = element.find('.right')
  left    = element.find('.left')
  top     = element.find('.top')
  bottom  = element.find('.bottom')
  
  front.transform   rotateY: '0deg',   'translateZ': '100px'
  back.transform    rotateX: '180deg', 'translateZ': '100px'
  right.transform   rotateY: '90deg',  'translateZ': '100px'
  left.transform    rotateY: '-90deg', 'translateZ': '100px'
  top.transform     rotateX: '90deg',  'translateZ': '100px'
  bottom.transform  rotateX: '-90deg', 'translateZ': '100px'
  
  $(@).bind 'cube' (e, type) ->
    $(@).gfx($.merge(sides[type], translateZ: '-100px'), options)