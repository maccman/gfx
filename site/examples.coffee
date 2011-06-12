$ = jQuery

$ ->
  
  $("#boxes").click ->
    $(this).gfx(scale: "1.5")
      .delay(100)
      .gfx(scale: "1")
      .gfx(rotate: "180deg")
      .delay(300)
      .gfx(rotate: "0deg")
      .gfx(translateX: "-100px")
      .delay(0)
      .gfx(translateX: "100px", opacity: 0.2)
      .delay(0)
      .gfx(translateX: 0, opacity: 1)
    
    $(this).gfxExplodeOut().delay(100).gfxExplodeIn();  
    $(this).gfxShake();
        
  $(".box").dblclick ->
    $.gfxBox("Yo there")
  
  $("#boxes").gfxFlip().click -> $(this).trigger("flip")