

library(jsonlite)
library(tibble)
library(tidyr) # v list-columns
library(magrittr)

# j <- jsonlite::read_json('json/tree.json', simplifyVector = FALSE)

# dput(as.numeric(do.call(rbind, dput(j$elements[[1]]$points))))

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

j <- jsonlite::read_json('json/multi.json', simplifyVector = FALSE)

xs <- vapply(j$elements, "[[",'x', FUN.VALUE = pi)
ys <- vapply(j$elements, "[[",'y', FUN.VALUE = pi)
ws <- vapply(j$elements, "[[",'width', FUN.VALUE = pi)
hs <- vapply(j$elements, "[[",'height', FUN.VALUE = pi)

rs <- gly_glyph(type = c('rectangle','rectangle','rectangle','ellipse'),
                x = xs, y = ys, 
                width = ws, height = hs, 
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

rs
# A tibble: 4 x 5
# x     y width height attributes      
# <dbl> <dbl> <dbl>  <dbl> <list>          
#   1 -156    -80   400    300 <named list [2]>
#   2  262    -80   400    300 <named list [2]>
#   3 -156    240   400    300 <named list [3]>
#   4  263.   240   400    300 <named list [2]>
att <- rs %>% unnest_wider(attributes)
att
invoke(a$add, pmap(att, miniexcali::g_element))

tree <- matrix(c(0, 8, 6, -34, -102, -143, -136, -112, -36, 7, 10, 4, -28, -68, 
                 -84, -84, -101, -101, -81, -69, -59, -44, -35, 7, 11, 11, -37, 
                 -49, -49, -48, -45, -39, -8, 9, 39, 55, 58, 104, 133, 161, 161, 
                 159, 142, 90, 78, 119, 139, 181, 191, 199, 204, 218, 231, 224, 
                 214, 103, 103, 79, 77, 77, 92, 98, 100, 114, 128, 173, 185, 201, 
                 221, 256, 265, 253, 246, 230, 225, 122, 57, 54, 58, 56, 58, 57, 
                 -1, -2, 1, 0, 0, -84, -87, -91, -82, -67, -82, -109, -169, -189, 
                 -196, -200, -201, -193, -184, -183, -190, -198, -219, -229, -242, 
                 -250, -251, -283, -291, -300, -302, -305, -312, -312, -319, -326, 
                 -352, -360, -384, -406, -406, -340, -316, -301, -297, -294, -289, 
                 -287, -285, -264, -260, -242, -241, -237, -232, -222, -200, -195, 
                 -192, -192, -191, -190, -193, -191, -173, -169, -165, -158, -155, 
                 -134, -127, -125, -119, -95, -84, -74, -70, -69, -71, -72, -79, 
                 -58, -41, -17, 6, 11, 15, 4, -2, 0), ncol=2, byrow = FALSE)

tree_g <- gly_glyph(type = 'draw',  
                    x=186,
                    y=423,
                    width=408,
                    height=421, attributes=list(list()))

tree_g$attributes = list(list(
  strokeColor = "#2b8a3e",
  backgroundColor = "#40c057",
  fillStyle = "cross-hatch", points = list(tree)))

att <- tree_g %>% unnest_wider(attributes)
a$add(invoke(miniexcali::g_element, att))
a$export('strip.json')
