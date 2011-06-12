$ = @jQuery

throw 'jQuery required' unless $

$.support.grafx = 'webkitTransitionEnd' of window

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

$.fn.grafx = (properties, options) ->
  opts = $.extend({}, defaults, options)
  
  unless typeof opts.duration is 'string'
    opts.duration += 'ms'

  properties['-webkit-transition'] = "all #{opts.duration} #{opts.easing}"
  
  callback = ->
    opts.complete?.apply(this, arguments)
    $(@).dequeue()

  @[ if opts.queue is false then 'each' else 'queue' ] ->
    $(@).one('webkitTransitionEnd', callback)
    $(@).transform(properties)

$.fn.grafxPopIn = (options) ->
  $(@).queueNext ->   
    $(@).transform
      '-webkit-transform-origin': '50% 50%'
      scale:   '.2'
      opacity: '0',
      display: 'block'

  $(@).grafx({
    scale:   '1'
    opacity: '1'
  }, options)

$.fn.grafxPopOut = (options) ->
  $(@).queueNext ->   
    $(@).transform
      '-webkit-transform-origin': '50% 50%'
      scale:   '1'
      opacity: '1'
  $(@).grafx({
    scale:   '.2'
    opacity: '0'
  }, options)
  
  $(@).queueNext -> 
    $(@).transform
      display: 'none'
      opacity: '1'
      scale:   '1'

$.fn.grafxFadeIn = (options = {}) ->
  options.duration ?= 1000
  $(@).queueNext -> 
    $(@).css 
      display: 'block'
      opacity: '0'
  $(@).grafx({opacity: 1}, options);

$.fn.grafxFadeOut = (options = {}) ->
  $(@).queueNext ->   
    $(@).css
      opacity: 1
  $(@).grafx({opacity: 0}, options);
  $(@).queueNext ->
    $(@).css
      display: 'none'
      opacity: 1

$.fn.grafxShake = (options = {}) ->
  options.duration ?= 100
  options.easing   ?= 'ease-out'
  distance = options.distance or 20
  $(@).grafx({translateX: "-#{distance}px"}, options)
  $(@).grafx({translateX: "#{distance}px"}, options)
  $(@).grafx({translateX: "-#{distance}px"}, options)
  $(@).grafx({translateX: "#{distance}px"}, options)
  $(@).queueNext ->
    $(@).transform(translateX: 0)

$.fn.grafxBlip = (options = {}) ->
  scale = options.scale or '1.15'
  $(@).grafx({scale: scale}, options)
  $(@).grafx({scale: '1'}, options)

$.fn.grafxExplodeIn = (options = {}) ->
  scale = options.scale or '3'
  $(@).queueNext ->
    $(@).transform(scale: scale, opacity: '0', display: 'block')
  $(@).grafx({scale: '1', opacity: '1'}, options)

$.fn.grafxExplodeOut = (options = {}) ->
  scale = options.scale or '3'
  $(@).queueNext ->
    $(@).transform(scale: '1', opacity: '1')
  $(@).grafx({scale: scale, opacity: '0'}, options)
  $(@).queueNext ->
    $(@).transform(scale: '1', opacity: '1', display: 'none')
    
$.fn.grafxFlipIn = (options = {}) ->
  $(@).queueNext ->
    $(@).transform(rotateY: '180deg', scale: '.8')
  $(@).grafx({rotateY: 0, scale: 1}, options)

$.fn.grafxFlipOut = (options = {}) ->
  $(@).queueNext ->
    $(@).transform(rotateY: 0, scale: 1)
  $(@).grafx({rotateY: '-180deg', scale: '.8'}, options)