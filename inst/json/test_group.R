

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

## grab locations of rectangles from manual drawing

rs <- gly_glyph(type = c('rectangle','rectangle','rectangle','ellipse'),
                x = .strip$x, y = .strip$y, 
                width = .strip$width, height = .strip$height, 
                attributes = lapply(seq_along(.strip$x), 
                                    function(ii)
                  list(fillStyle = "cross-hatch",
                       groups = c("mygroup","group2"),
                       strokeWidth = 2L)))


rs[4,]$attributes[[1]] <- append(rs[4,]$attributes[[1]], 
                                 list(roughness=0,angle=pi/8))

a <- Excali_doc()

att <- rs %>% unnest_wider(attributes)
invoke(a$add, pmap(att, minixcali::g_element))

a$export('group.json')

