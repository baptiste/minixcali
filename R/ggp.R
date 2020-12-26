
#' @export
#' @importFrom egg expose_layout
ggp <- function(){
  
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
  invoke(a$add, pmap(att, minixcali::g_element))
  
  
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
                                      strokeSharpness= "round",
                                      groups = c("roberto"),
                                      strokeColor = l$strokeColor,
                                      backgroundColor = l$backgroundColor,
                                      fillStyle = "solid", 
                                      points = l$points))
    
    att <- new_stroke %>% unnest_wider(attributes)
    a$add(invoke(minixcali::g_element, att))
    
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
                                      strokeSharpness= "round",
                                      groups = c("kevin"),
                                      strokeColor = l$strokeColor,
                                      backgroundColor = l$backgroundColor,
                                      fillStyle = "solid", 
                                      points = l$points))
    
    att <- new_stroke %>% unnest_wider(attributes)
    a$add(invoke(minixcali::g_element, att))
    
  }
  
  
  a
  
}

if(FALSE){
  library(ggplot2)
  
  p <- qplot(mpg, wt, data=mtcars, colour=cyl)+ 
    # facet_wrap(~carb, nrow=1) +
    ggtitle('facetted plot')
  g <- expose_layout(p, draw = T)
  g$widths[[which(grepl('panel',l$name))]] <- unit(3,'cm')
  g$heights[[which(grepl('panel',l$name))]] <- unit(2,'cm')
  w <- grid::convertWidth(g$widths,'mm', valueOnly = TRUE)
  cw <- c(0, cumsum(w))
  h <- grid::convertHeight(g$heights,'mm', valueOnly = TRUE)
  ch <- c(0, cumsum(h))
  l <- g$layout
  gl <- vector(length=nrow(l), mode='list')
  scale <- 10
  for(ii in 1:nrow(l)){
    el <- l[ii,]
    gl[[ii]] <- list(name=el$name, 
                     x = 10*cw[el$l], y = 10*ch[el$b], 
                     width = 10*(cw[el$r+1] - cw[el$l]),
                     height = 10*(ch[el$t+1] - ch[el$b]))
  }
  att <- data.frame(do.call(rbind, gl)) 
  att <- subset(att, !grepl('spacer',name))
  att$type <- 'rectangle'
  
  a <- Excali_doc()
  invoke(a$add, pmap(att, minixcali::g_element))
  
  a$export('ggp.json')
}
