$ = @jQuery

throw 'jQuery required' unless $

$.support.gfx = 'webkitTransitionEnd' of window

defaults = 
  duration: 400 
  queue: true
  easing: ''
  
transformTypes = [
  'scale', 'scaleX', 'scaleY', 'scale3d',
  'rotate', 'rotateX', 'rotateY', 'rotateZ', 'rotate3d',
  'translate', 'translateX', 'translateY', 'translateZ', 'translate3d',
  'skew', 'skewX', 'skewY', 
  'matrix', 'matrix3d', 'perspective'
]

$.fn.queueNext = (callback, type) ->
	type or= "fx";
	
	@queue ->
	  callback.apply(this, arguments)
	  setTimeout =>
	    jQuery.dequeue(this, type)

$.fn.transform = (properties) ->
  transforms = []

  for key, value of properties when key in transformTypes
    transforms.push("#{key}(#{value})")
    delete properties[key]
  
  if transforms.length
    properties['-webkit-transform'] = transforms.join(' ')

  $(@).css(properties)

$.fn.gfx = (properties, options) ->
  opts = $.extend({}, defaults, options)
  
  unless typeof opts.duration is 'string'
    opts.duration += 'ms'

  properties['-webkit-transition'] = "all #{opts.duration} #{opts.easing}"
  
  callback = ->
    $(@).css('-webkit-transition', '')
    opts.complete?.apply(this, arguments)
    $(@).dequeue()

  @[ if opts.queue is false then 'each' else 'queue' ] ->
    $(@).one('webkitTransitionEnd', callback)
    $(@).transform(properties)

$.fn.gfxPopIn = (options) ->
  $(@).queueNext ->   
    $(@).transform
      '-webkit-transform-origin': '50% 50%'
      scale:   '.2'
      opacity: '0',
      display: 'block'

  $(@).gfx({
    scale:   '1'
    opacity: '1'
  }, options)

$.fn.gfxPopOut = (options) ->
  $(@).queueNext ->   
    $(@).transform
      '-webkit-transform-origin': '50% 50%'
      scale:   '1'
      opacity: '1'
  $(@).gfx({
    scale:   '.2'
    opacity: '0'
  }, options)
  
  $(@).queueNext -> 
    $(@).transform
      display: 'none'
      opacity: '1'
      scale:   '1'

$.fn.gfxFadeIn = (options = {}) ->
  options.duration ?= 1000
  $(@).queueNext -> 
    $(@).css 
      display: 'block'
      opacity: '0'
  $(@).gfx({opacity: 1}, options);

$.fn.gfxFadeOut = (options = {}) ->
  $(@).queueNext ->   
    $(@).css
      opacity: 1
  $(@).gfx({opacity: 0}, options);
  $(@).queueNext ->
    $(@).css
      display: 'none'
      opacity: 1

$.fn.gfxShake = (options = {}) ->
  options.duration ?= 100
  options.easing   ?= 'ease-out'
  distance = options.distance or 20
  $(@).gfx({translateX: "-#{distance}px"}, options)
  $(@).gfx({translateX: "#{distance}px"}, options)
  $(@).gfx({translateX: "-#{distance}px"}, options)
  $(@).gfx({translateX: "#{distance}px"}, options)
  $(@).queueNext ->
    $(@).transform(translateX: 0)

$.fn.gfxBlip = (options = {}) ->
  scale = options.scale or '1.15'
  $(@).gfx({scale: scale}, options)
  $(@).gfx({scale: '1'}, options)

$.fn.gfxExplodeIn = (options = {}) ->
  scale = options.scale or '3'
  $(@).queueNext ->
    $(@).transform(scale: scale, opacity: '0', display: 'block')
  $(@).gfx({scale: '1', opacity: '1'}, options)

$.fn.gfxExplodeOut = (options = {}) ->
  scale = options.scale or '3'
  $(@).queueNext ->
    $(@).transform(scale: '1', opacity: '1')
  $(@).gfx({scale: scale, opacity: '0'}, options)
  $(@).queueNext ->
    $(@).transform(scale: '1', opacity: '1', display: 'none')
    
$.fn.gfxFlipIn = (options = {}) ->
  $(@).queueNext ->
    $(@).transform(rotateY: '180deg', scale: '.8')
  $(@).gfx({rotateY: 0, scale: 1}, options)

$.fn.gfxFlipOut = (options = {}) ->
  $(@).queueNext ->
    $(@).transform(rotateY: 0, scale: 1)
  $(@).gfx({rotateY: '-180deg', scale: '.8'}, options)