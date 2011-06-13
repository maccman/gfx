$ = jQuery

defaults = 
  width: 120
  height: 120

$.fn.gfxFlip = (options = {}) ->
  opts = $.extend({}, defaults, options)
  
  front = $(@).find('.front')
  back  = $(@).find('.back')
  
  $(@).css(
    'position': 'relative'
    '-webkit-perspective': '600'
    '-moz-perspective': '600'
    '-webkit-transform-style': 'preserve-3d'
    '-moz-transform-style': 'preserve-3d'
    '-webkit-transform-origin': '50% 50%'
    '-moz-transform-origin': '50% 50%'
    'width': opts.width;
    'height': opts.height;
  )
  
  front.add(back).css
    position: 'absolute'
    width:    '100%'
    height:   '100%'
    display:  'block'
    '-webkit-backface-visibility': 'hidden'
    '-moz-backface-visibility': 'hidden'
  
  back.transform
    rotateY: '-180deg'
  
  $(@).bind 'flip', ->
    $(@).toggleClass('flipped')
    flipped = $(@).hasClass('flipped')
    
    front.gfx('rotateY': if flipped then '180deg' else '0deg')
    back.gfx('rotateY': if flipped then '0deg' else '-180deg')
