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

# Internal helper functions

$.gfx.fn.redraw = ->
  @each -> @offsetHeight

$.gfx.fn.queueNext = (callback, type = 'fx') ->
  @queue ->
    callback.apply(this, arguments)
    $(this).gfx('redraw')
    jQuery.dequeue(this, type)

# Helper function for easily adding transforms

$.gfx.fn.transform = (properties, options) ->
  opts = $.extend({}, defaults, options)
  return this unless opts.enabled

  transforms = []

  for key, value of properties when key in transformTypes
    # TODO - add px
    transforms.push("#{key}(#{value})")
    delete properties[key]

  if transforms.length
    properties[n.transform] = transforms.join(' ')

  if opts.origin
    properties["#{prefix}transform-origin"] = opts.origin

  @css(properties)

$.gfx.fn.animate = (properties, options) ->
  opts = $.extend({}, defaults, options)
  properties[n.transition] = "all #{opts.duration}ms #{opts.easing}"

  callback = ->
    $(this).css(n.transition, '')
    opts.complete?.apply(this, arguments)
    $(this).dequeue() if opts.queue

  @[ if opts.queue is false then 'each' else 'queue' ] ->

    if opts.enabled
      $(this).one(n.transitionEnd, callback)
      $(this).gfx('transform', properties)

      # Sometimes the event doesn't fire, so we have to fire it manually
      $(this).gfx('emulateTransitionEnd', opts.duration + 50)

    else
      $(this).gfx('transform', properties)
      do callback

# Private

$.gfx.fn.emulateTransitionEnd = (duration) ->
  called = false
  $(this).one(n.transitionEnd, -> called = true)
  callback = => $(this).trigger(n.transitionEnd) unless called
  setTimeout(callback, duration)
