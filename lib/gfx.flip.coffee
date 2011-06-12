
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
    '-webkit-backface-visibility': 'hidden'
  
  back.transform
    rotateY: '180deg'
  
  $(@).bind 'flip', ->
    $(@).toggleClass('flipped')
    flipped = $(@).hasClass('flipped')
    $(@).gfx('rotateY': if flipped then '180deg' else '0deg')
