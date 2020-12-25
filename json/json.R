

library(jsonlite)
library(tibble)
library(tidyr) # v list-columns
library(magrittr)

gly_rectangle <- function(x, y, width, height, attributes = list()){
  tb <- tibble::tibble(x = x, y = y, width = width, height = height)
  tb$attributes <- attributes
  tb
}

j <- jsonlite::read_json('json/multi.json', simplifyVector = FALSE)

xs <- vapply(j$elements, "[[",'x', FUN.VALUE = pi)
ys <- vapply(j$elements, "[[",'y', FUN.VALUE = pi)
ws <- vapply(j$elements, "[[",'width', FUN.VALUE = pi)
hs <- vapply(j$elements, "[[",'height', FUN.VALUE = pi)

rs <- gly_rectangle(x = xs, y = ys, width = ws, height = hs, 
                    attributes = lapply(seq_along(xs), function(ii)
                      list(fillStyle = if(ii%%2) "hachure" else "solid", 
                           strokeWidth = 1L)))
rs[3,]$attributes[[1]] <- append(rs[3,]$attributes[[1]], 
                                 list(backgroundColor = '#80FFFF'))
str(rs)

library(tidyr)
rs %>% unnest_wider(attributes)

library(miniexcali)

# rs <- tribble(~x, ~y, ~width, ~height,
#               -156 ,   -80,   400,    300,
#               262 ,   -80,   400,    300,
#               -156 ,   240,   400,    300,
#               263.,   240,   400,    300)

a <- Excali_doc()
# for(ii in 1:nrow(rs))
#   a$add_rectangle(x = rs$x[ii], y = rs$y[ii], 
#                   width = rs$width[ii], height = rs$height[ii])

library(purrr)
library(tidyr)
att <- rs %>% unnest_wider(attributes)
invoke(a$add, pmap(att, miniexcali::g_rectangle))

a$export('strip.json')
