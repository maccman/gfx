$        = jQuery
$.gfx    = {}
$.gfx.fn = {}
$.fn.gfx = (method, args...) ->
  $.gfx.fn[method].apply(this, args)

$.support.transition or= do ->
  style = (new Image).style
  'transition' of style or
   'webkitTransition' of style or
    'MozTransition' of style or
      'msTransition' of style

vendor = if $.browser.mozilla then 'moz'
vendor = if $.browser.mozilla then 'ms'
vendor or= 'webkit'
prefix = "-#{vendor}-"

vendorNames = n =
  transition: "#{prefix}transition"
  transform: "#{prefix}transform"
  transitionEnd: "#{vendor}TransitionEnd"

defaults =
  duration: 400
  queue: true
  easing: ''
  enabled: $.support.transition

transformTypes = [
  'scale', 'scaleX', 'scaleY', 'scale3d',
  'rotate', 'rotateX', 'rotateY', 'rotateZ', 'rotate3d',
  'translate', 'translateX', 'translateY', 'translateZ', 'translate3d',
  'skew', 'skewX', 'skewY',
  'matrix', 'matrix3d', 'perspective'
]

transformTypesPx  = ['translate', 'translateX', 'translateY', 'translateZ', 'translate3d']
transformTypesDeg = ['rotate', 'rotateX', 'rotateY']
rnumpx            = /^-?\d+(?:px)?$/i
rnumdeg           = /^-?\d+(?:deg)?$/i

emulateTransitionEnd = (duration) ->
  called = false
  $(@).one(n.transitionEnd, -> called = true)
  callback = => $(@).trigger(n.transitionEnd) unless called
  setTimeout(callback, duration)

transformProperty = (key, values) ->
  values = $.makeArray(values)

  for value, i in values
    if key in transformTypesPx and rnumpx.test(value)
      values[i] += 'px'

    if key in transformTypesDeg and rnumdeg.test(value)
      values[i] += 'deg'

  values.join(',')

# Public

$.gfx.fn.redraw = ->
  @each -> @offsetHeight

$.gfx.fn.queueNext = (callback, type = 'fx') ->
  @queue ->
    callback.apply(this, arguments)
    $(this).gfx('redraw')
    jQuery.dequeue(this, type)

# Helper function for easily adding transforms

$.gfx.fn.transform = (properties, options) ->
  options = $.extend({}, defaults, options)
  return this unless options.enabled

  transforms = []

  for key, value of properties when key in transformTypes
    value = transformProperty(key, value)
    transforms.push("#{key}(#{value})")
    delete properties[key]

  if transforms.length
    properties[n.transform] = transforms.join(' ')

  if options.origin
    properties["#{prefix}transform-origin"] = options.origin

  @css(properties)

$.gfx.fn.animate = (properties, options) ->
  options = $.extend({}, defaults, options)
  properties[n.transition] = "all #{options.duration}ms #{options.easing}"

  callback = ->
    $(@).css(n.transition, '')
    options.complete?.apply(this, arguments)
    $(@).dequeue() if options.queue

  @[ if options.queue is false then 'each' else 'queue' ] ->

    if options.enabled
      $(@).one(n.transitionEnd, callback)
      $(@).gfx('transform', properties)

      # Sometimes the event doesn't fire, so we have to fire it manually
      emulateTransitionEnd.call(this, options.duration + 50)

    else
      $(@).gfx('transform', properties)
      do callback
