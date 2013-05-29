# Additional Effects

$ = jQuery

unless $.gfx
  throw new Error('GFX required')

$.fn.animate = $.gfx.fn.animate
$.fn.transform = $.gfx.fn.transform
$.fn.queueNext = $.gfx.fn.queueNext

$.gfx.BOUNCING = 'cubic-bezier(.41,1.34,.51,1.01)'
$.gfx.HARD_BOUNCING = 'cubic-bezier(.35,1.83,.62,1)'

$.gfx.fn.popIn = (options = {}) ->
  options.scale ?= '.2'

  $(@).queueNext ->
    $(@).transform(
      origin: '50% 50%'
      scale: options.scale
    ).show()

  $(@).animate(
    scale:   '1'
    opacity: '1'
  , options)

$.gfx.fn.popOut = (options) ->
  $(@).queueNext ->
    $(@).transform
      origin: '50% 50%'
      scale:   '1'
      opacity: '1'

  $(@).animate({
    scale:   0.2
    opacity: 0
  }, options)

  $(@).queueNext ->
    $(@).hide().transform(
      opacity: 1
      scale:   1
    )

$.gfx.fn.fadeIn = (options = {}) ->
  options.duration ?= 1000
  $(@).queueNext ->
    $(@).css(opacity: 0).show()
  $(@).animate({opacity: 1}, options);

$.gfx.fn.fadeOut = (options = {}) ->
  $(@).queueNext ->
    $(@).css(opacity: 1)
  $(@).animate({opacity: 0}, options)
  $(@).queueNext ->
    $(@).hide().css(opacity: 1)

$.gfx.fn.shake = (options = {}) ->
  options.duration ?= 100
  options.easing   ?= 'ease-out'
  distance = options.distance or 20
  $(@).animate(translateX: -distance, options)
  $(@).animate(translateX: distance, options)
  $(@).animate(translateX: -distance, options)
  $(@).animate(translateX: distance, options)
  $(@).queueNext ->
    $(@).transform(translateX: 0)

$.gfx.fn.blip = (options = {}) ->
  options.scale or= 1.15
  $(@).animate(scale: options.scale, options)
  $(@).animate(scale: 1, options)

$.gfx.fn.explodeIn = (options = {}) ->
  options.scale or= 3
  $(@).queueNext ->
    $(@).transform(scale: options.scale, opacity: 0).show()
  $(@).animate(scale: 1, opacity: 1, options)

$.gfx.fn.explodeOut = (options = {}) ->
  options.scale or= 3
  $(@).queueNext ->
    $(@).transform(scale: 1, opacity: 1)
  $(@).animate(scale: options.scale, opacity: 0, options)

  unless options.reset is false
    $(@).queueNext ->
      $(@).hide().transform(scale: 1, opacity: 1)
  this

$.gfx.fn.flipIn = (options = {}) ->
  $(@).queueNext ->
    $(@).transform(rotateY: 180, scale: 0.8, display: 'block')
  $(@).animate(rotateY: 0, scale: 1, options)

$.gfx.fn.flipOut = (options = {}) ->
  $(@).queueNext ->
    $(@).transform(rotateY: 0, scale: 1)
  $(@).animate(rotateY: -180, scale: 0.8, options)

  unless options.reset is false
    $(@).queueNext ->
      $(@).transform(scale: 1, rotateY: 0, display: 'none')
  this

$.gfx.fn.rotateOut = (options = {}) ->
  $(@).queueNext ->
    $(@).transform(rotateY: 0).fix()
  $(@).animate(rotateY: 180, options)

  unless options.reset is false
    $(@).queueNext ->
      $(@).transform(rotateY: 0, display: 'none').unfix()
  this

$.gfx.fn.rotateIn = (options = {}) ->
  $(@).queueNext ->
    $(@).transform(rotateY: '180deg', display: 'block').fix()
  $(@).animate(rotateY: 0, options)
  $(@).queueNext -> $(@).unfix()

$.gfx.fn.shiftOut = (options = {}) ->
  options.direction or= 'down'

  distance = options.distance or 100
  distance *= -1 if options.direction is 'up'
  distance += "%"

  opacity = if options.fade then 0 else 1

  $(@).queueNext -> $(@).show()
  $(@).animate(translate3d: [0,distance,0], opacity: opacity, options)
  $(@).queueNext ->
    $(@).transform(translate3d: [0, 0, 0], opacity: 1).hide()

$.gfx.fn.shiftIn = (options = {}) ->
  options.direction or= 'down'

  distance = options.distance or 100
  distance *= -1 if options.direction is 'up'
  distance += "%"

  opacity = if options.fade then 0 else 1

  $(@).queueNext ->
    $(@).transform(translate3d: [0, distance, 0], opacity: opacity).show()
  $(@).animate(translate3d: [0, 0, 0], opacity: 1, options)

$.gfx.fn.slideOut = (options = {}) ->
  options.direction or= 'right'

  distance = options.distance or 100
  distance *= -1 if options.direction is 'left'
  distance += "%"

  opacity = if options.fade then 0 else 1

  $(@).queueNext -> $(@).show()
  $(@).animate(translate3d: [distance,0,0], opacity: opacity, options)
  $(@).queueNext ->
    $(@).transform(translate3d: [0,0,0], opacity: 1).hide()

$.gfx.fn.slideIn = (options = {}) ->
  options.direction or= 'right'

  distance = options.distance or 100
  distance *= -1 if options.direction is 'left'
  distance += "%"

  opacity = if options.fade then 0 else 1

  $(@).queueNext ->
    $(@).transform(translate3d: [distance, 0, 0], opacity: opacity).show()
  $(@).animate(translate3d: [0, 0, 0], opacity: 1, options)

$.gfx.fn.raisedIn = (options = {}) ->
  $(@).queueNext ->
    $(@).transform(scale: 1, opacity: 0, translate3d: [0, 15, 0]).show()
  $(@).animate(scale: 1, opacity: 1, translate3d: [0, 0, 0], options)

$.gfx.fn.raisedOut = (options = {}) ->
  $(@).queueNext ->
    $(@).transform(scale: 1, opacity: 1, translate3d: [0, 0, 0])
  $(@).animate({scale: 1, opacity: 0, translate3d: [0, 8, 0]}, options)

  $(@).queueNext ->
    $(@).hide().transform(scale: 1, opacity: 1, translate3d: [0, 0, 0])

$.gfx.fn.fix = ->
  $(@).each ->
    $element        = $(@)
    styles          = $element.offset()
    parentOffset    = $element.parent().offset()
    styles.left    -= parentOffset.left
    styles.top     -= parentOffset.top
    styles.position = 'absolute'
    $element.css(styles)

$.gfx.fn.unfix = ->
  $(@).each ->
    element = $(@)
    element.css(position: '', top:'', left: '')