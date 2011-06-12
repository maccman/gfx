$ = jQuery

isOpen = ->
  !!$('#grafxBox').length

close = ->
  box = $('#grafxBox')
  console.log(box.find('#grafxBoxPanel'))
  box.find('#grafxBoxPanel').grafx(scale: '1.1', opacity: 0)
  box.grafx(background: 'rgba(0,0,0,0)')
  box.queueNext -> box.remove()
  
panelCSS = 
  opacity:    0
  scale:      0.5
  width:      500
  minHeight:  400
  padding:    15
  margin:     '10% auto'
  background: '#E3E3E3'
  
overlayStyles = 
  position:   'fixed'
  zIndex:     99
  top:        0
  left:       0
  width:      '100%'
  height:     '100%'
  background: 'rgba(0,0,0,0)'

$.grafxBox = (element, options = {}) ->
  close() if isOpen()
  
  overlay = $('<div />').attr('id': 'grafxBox')
  overlay.css(overlayStyles)
  overlay.click(close)
  overlay.delegate('.close', 'click', close)
  overlay.bind('close', close)

  panel = $('<div />').attr('id': 'grafxBoxPanel')
  panel.transform($.extend({}, panelCSS, options.css))

  panel.append(element)
  overlay.append(panel)
  $('body').append(overlay)
  
  overlay.delay().grafx({background: 'rgba(0,0,0,0.5)'}, {duration: options.duration})
  panel.delay().grafx({scale: 1, opacity: 1})