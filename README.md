#GFX 

#Basic usage

    <script src="lib/gfx.js" type="text/javascript" charset="utf-8"></script>  
    
    $("#element").gfx(properties, options)
    
    $(this).gfx({
      scale: "1.5",
      rotate: "180deg"
    })
    
Chaining, delay
    
    .gfx({
      rotate: "0deg",
      translateX: "-100px"
    }).delay(100).gfx({
      scale: "1"
    }).gfx({
      rotate: "0deg",
      translateX: "-100px"
    })
    
        
    $.fn.gfxExplodeOut()
    $.fn.gfxExplodeIn()
    $.fn.gfxBlip()
    $.fn.gfxFadeIn()
    $.fn.gfxFadeOut()
    
    
#Overlay
    
    <script src="lib/gfx.overlay.js" type="text/javascript" charset="utf-8"></script>
    
#Flip

    <script src="lib/gfx.flip.js" type="text/javascript" charset="utf-8"></script>
    
#Cube

    <script src="lib/gfx.cube.js" type="text/javascript" charset="utf-8"></script>

# Demos

http://desandro.github.com/3dtransforms/

Time machine
Windows 8
