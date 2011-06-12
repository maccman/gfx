$ = jQuery

isOpen = ->
  !!$('#gfxBox').length

close = ->
  box = $('#gfxBox')
  console.log(box.find('#gfxBoxPanel'))
  box.find('#gfxBoxPanel').gfx(scale: '1.1', opacity: 0)
  box.gfx(background: 'rgba(0,0,0,0)')
  box.queueNext -> box.remove()
  
panelCSS = 
  opacity:    0
  scale:      0.5
  width:      500
  minHeight:  400
  padding:    15
  margin:     '10% auto'
  background: '#E3E3E3'
  border:     '1px solid #FFF'
  '-webkit-box-shadow': '0 0 20px rgba(0,0,0,0.4)'
  
overlayStyles = 
  position:   'fixed'
  zIndex:     99
  top:        0
  left:       0
  width:      '100%'
  height:     '100%'
  background: 'rgba(0,0,0,0)'

$.gfxBox = (element, options = {}) ->
  close() if isOpen()
  
  overlay = $('<div />').attr('id': 'gfxBox')
  overlay.css(overlayStyles)
  overlay.click(close)
  overlay.delegate('.close', 'click', close)
  overlay.bind('close', close)

  panel = $('<div />').attr('id': 'gfxBoxPanel')
  panel.transform($.extend({}, panelCSS, options.css))

  panel.append(element)
  overlay.append(panel)
  $('body').append(overlay)
  
  overlay.delay().gfx({background: 'rgba(0,0,0,0.5)'}, {duration: options.duration})
  panel.delay().gfx({scale: 1, opacity: 1})