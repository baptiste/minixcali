

library(jsonlite)
library(tibble)

gly_rect <- function(x, y, width, height, attributes = list()){
  tibble::tibble(x = x, y = y, width = width, height = height)
}

j <- jsonlite::read_json('json/multi.json', simplifyVector = FALSE)

xs <- vapply(j$elements, "[[",'x', FUN.VALUE = pi)
ys <- vapply(j$elements, "[[",'y', FUN.VALUE = pi)
ws <- vapply(j$elements, "[[",'width', FUN.VALUE = pi)
hs <- vapply(j$elements, "[[",'height', FUN.VALUE = pi)

rs <- gly_rect(x = xs, y = ys, width = w, height = h)

library(miniexcali)

rs <- tribble(~x,~y,~width,~height,
              -156 ,   -80,   400,    300,
               262 ,   -80,   400,    300,
              -156 ,   240,   400,    300,
               263.,   240,   400,    300)

a <- Excali_doc()
for(ii in 1:nrow(rs))
  a$add_rectangle(x = rs$x[ii], y = rs$y[ii], 
                  width = rs$width[ii], height = rs$height[ii])

a$export('strip.json')
