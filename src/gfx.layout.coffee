$ = jQuery

unless $.gfx
  throw new Error('GFX required')

defaults =
  selector: '> *'

animatePosition = (e, position) ->
  $element = $(e.target)
  $element.gfx 'animate',
    translate3d: [position.left, position.top, 0]
  $element.gfx 'queueNext', ->
    $element.gfx 'transform', translate3d: ''

animateShow = (e) ->
  $element = $(e.target)
  $element.gfx 'fadeIn'

animateHide = (e) ->
  $element = $(e.target)
  $element.gfx 'fadeOut'

$.gfx.fn.layoutPosition = ($clone) ->
  {cTop, cLeft} = $clone.position()
  {top, left}   = @position()

  if cLeft isnt left or cTop isnt top
    @trigger(
      'position.layout.gfx',
      left: cLeft - left, top: cTop - top
    )

$.gfx.fn.layoutDisplay = ($clone) ->
  cDisplay = $clone.css('display')
  display  = @css('display')

  return if cDisplay is display

  if cDisplay is 'none'
    @trigger('hide.layout.gfx')
  else
    @trigger('show.layout.gfx')

$.gfx.fn.layout = (options = {}) ->
  options = $.extend({}, defaults, options)
  $clone  = options.clone or @clone()
  $clone.addClass(options.className) if options.className

  $clone.css(position: 'absolute', left: -9999, top: -9999).appendTo('body')

  @on 'position.layout.gfx', animatePosition
  @on 'show.layout.gfx', animateShow
  @on 'hide.layout.gfx', animateHide

  $nodes  = @find(options.selector)
  $clones = $clone.find(options.selector)

  $nodes.each (index, node) ->
    $node  = $(node)
    $clone = $($clones.get(index))
    $node.gfx('layoutPosition', $clone)
    $node.gfx('layoutDisplay', $clone)

  $clone.remove()
  @off 'layout.gfx'
