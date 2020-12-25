
#' @export
pdl_strip <- function(){
  
  rs <- gly_glyph(type = 'rectangle',
                  x = .strip$x, y = .strip$y, 
                  width = .strip$width, height = .strip$height, 
                  attributes = lapply(seq_along(.strip$x), 
                                      function(ii)
                                        list(fillStyle =  "solid",
                                             backgroundColor = "#f7fdff",
                                             strokeWidth = 2L)))
  
  
  a <- Excali_doc()
  
  att <- rs %>% unnest_wider(attributes)
  invoke(a$add, pmap(att, miniexcali::g_element))
  
  
  ## add kevin and roberto
  
  for(l in .roberto){
    new_stroke <- gly_glyph(type = 'line',  
                            x=l$x,
                            y=l$y,
                            width=l$width,
                            height=l$height,
                            attributes=list(list(roughness=1)))
    
    new_stroke$attributes = list(list(strokeWidth = 1L,
                                      roughness=0L,
                                      groups = c("roberto"),
                                      strokeColor = l$strokeColor,
                                      backgroundColor = l$backgroundColor,
                                      fillStyle = "solid", 
                                      points = l$points))
    
    att <- new_stroke %>% unnest_wider(attributes)
    a$add(invoke(miniexcali::g_element, att))
    
  }
  
  
  for(l in .kevin){
    new_stroke <- gly_glyph(type = 'line',  
                            x=l$x,
                            y=l$y,
                            width=l$width,
                            height=l$height,
                            attributes=list(list(roughness=1)))
    
    new_stroke$attributes = list(list(strokeWidth = 1L,
                                      roughness=0L,
                                      groups = c("kevin"),
                                      strokeColor = l$strokeColor,
                                      backgroundColor = l$backgroundColor,
                                      fillStyle = "solid", 
                                      points = l$points))
    
    att <- new_stroke %>% unnest_wider(attributes)
    a$add(invoke(miniexcali::g_element, att))
    
  }
  
  
  a
  
}

if(FALSE){
  a <- pdl_strip()
  a$export('strip.json')
}
