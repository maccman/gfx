
$ = jQuery

$.fn.gfxFlip = (options = {}) ->
  front = $(@).find('.front')
  back  = $(@).find('.back')
  
  $(@).css(
    'position': 'relative'
  )
  
  front.add(back).css
    position: 'absolute'
    width:    '100%'
    height:   '100%'
    display:  'block'
    
  front.css
    '-webkit-backface-visibility': 'hidden'
  
  back.transform
    rotateY: '180deg'
  
  flipped = false
  $(@).bind 'flip', ->
    flipped = not flipped
    $(@).gfx('rotateY': if flipped then '180deg' else '0deg')
