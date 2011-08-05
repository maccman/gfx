$ = jQuery

isOpen = ->
  !!$('#gfxOverlay').length

close = ->
  overlay = $('#gfxOverlay')
  overlay.find('#gfxOverlayPanel').gfx(scale: '1.1', opacity: 0)
  overlay.gfx(background: 'rgba(0,0,0,0)')
  overlay.queueNext -> overlay.remove()
  
panelCSS = 
  opacity:    0
  scale:      0.5
  
overlayStyles = 
  display:    'block'
  position:   'fixed'
  zIndex:     99
  top:        0
  left:       0
  width:      '100%'
  height:     '100%'
  background: 'rgba(0,0,0,0)'

$.gfxOverlay = (element, options = {}) ->
  close() if isOpen()
  
  element = $(element)
  if element[0].tagName is 'SCRIPT'
    element = element.html()
  else
    element = element.clone()
    
  options.css or= {}
  options.css.width  = options.width  if options.width
  options.css.height = options.height if options.height
  
  overlay = $('<div />').attr('id': 'gfxOverlay')
  overlay.css(overlayStyles)
  overlay.click(close)
  overlay.delegate('.close', 'click', close)
  overlay.bind('close', close)

  panel = $('<div />').attr('id': 'gfxOverlayPanel')
  panel.transform($.extend({}, panelCSS, options.css))

  panel.append(element)
  overlay.append(panel)
  $('body').append(overlay)
  
  overlay.delay().gfx({background: 'rgba(0,0,0,0.5)'}, {duration: options.duration})
  panel.delay().gfx({scale: 1, opacity: 1}, {duration: options.duration})