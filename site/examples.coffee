$ = jQuery

$ ->

  $(".box").click ->
    $(this).grafx(scale: "1.5")
      .delay(100)
      .grafx(scale: "1")
      .grafx(rotate: "180deg")
      .delay(300)
      .grafx(rotate: "0deg")
      .grafx(translateX: "-100px")
      .delay(0)
      .grafx(translateX: "100px", opacity: 0.2)
      .delay(0)
      .grafx(translateX: 0, opacity: 1)
    
    $(this).grafxExplodeOut().delay(100).grafxExplodeIn();
    
    $(this).grafxShake();
    
    $(this).grafxFlipIn().delay(500).grafxFlipOut();