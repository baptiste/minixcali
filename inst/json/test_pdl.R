

library(minixcali)
library(jsonlite)
library(tibble)
library(tidyr) # v list-columns
library(magrittr)
library(purrr)
library(tidyr)
library(tidyr)

gly_glyph <- function(type,
                      x, y, 
                      width, height, 
                      attributes = list()){
  tb <- tibble::tibble(type = type, 
                       x = x, y = y, 
                       width = width, height = height)
  tb$attributes <- attributes
  tb
}


a <- Excali_doc()

scale <- 1
for(l in .roberto[1]){
  print(l)
  new_stroke <- gly_glyph(type = 'line',  
                       x=scale*l$x,
                       y=scale*l$y,
                       width=scale*l$width,
                       height=scale*l$height,
                       attributes=list(list(roughness=2)))
  
  new_stroke$attributes = list(list(strokeWidth = 1L,
                                 roughness=2L,
                                 groups = c("roberto"),
                                 strokeColor = l$strokeColor,
                                 backgroundColor = l$backgroundColor,
                                 fillStyle = "solid", 
                                 points = l$points))
  
  att <- new_stroke %>% unnest_wider(attributes)
  a$add(invoke(minixcali::g_element, att))
  
}


a$export('pdl.json')

# https://excalidraw.com/#json=6272303994241024,yokUkJYuUO4Sgl8TpXSbQw


