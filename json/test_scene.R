

library(miniexcali)
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
# j <- jsonlite::read_json('json/multi.json', simplifyVector = FALSE)
# 
# xs <- vapply(j$elements, "[[",'x', FUN.VALUE = pi)
# ys <- vapply(j$elements, "[[",'y', FUN.VALUE = pi)
# ws <- vapply(j$elements, "[[",'width', FUN.VALUE = pi)
# hs <- vapply(j$elements, "[[",'height', FUN.VALUE = pi)



rs <- gly_glyph(type = c('rectangle','rectangle','rectangle','ellipse'),
                x = .strip$x, y = .strip$y, 
                width = .strip$width, height = .strip$height, 
                attributes = lapply(seq_along(.strip$x), 
                                    function(ii)
                  list(fillStyle = dplyr::case_when(ii==1 ~ "solid",
                                             ii==2 ~ "hachure", 
                                             ii==3 ~ "solid", TRUE ~ "cross-hatch"),
                       strokeWidth = 2L)))

rs[1,]$attributes[[1]] <- append(rs[1,]$attributes[[1]], 
                                 list(backgroundColor = "#f7fdff"))

rs[2,]$attributes[[1]] <- append(rs[2,]$attributes[[1]], 
                                 list(roughness=2))

rs[3,]$attributes[[1]] <- append(rs[3,]$attributes[[1]], 
                                 list(roughness=1,
                                      backgroundColor = "#f7fdff"))

rs[4,]$attributes[[1]] <- append(rs[4,]$attributes[[1]], 
                                 list(roughness=0,angle=pi/8))

# rs <- tribble(~x, ~y, ~width, ~height,
#               -156 ,   -80,   400,    300,
#               262 ,   -80,   400,    300,
#               -156 ,   240,   400,    300,
#               263.,   240,   400,    300)

a <- Excali_doc()
# for(ii in 1:nrow(rs))
#   a$add_rectangle(x = rs$x[ii], y = rs$y[ii], 
#                   width = rs$width[ii], height = rs$height[ii])


att <- rs %>% unnest_wider(attributes)
invoke(a$add, pmap(att, miniexcali::g_element))


## grab coords of manually drawn tree

# j <- jsonlite::read_json('json/tree.json', simplifyVector = FALSE)
# dput(as.numeric(do.call(rbind, dput(j$elements[[1]]$points))))


tree <- miniexcali::.tree
tree_g <- gly_glyph(type = 'draw',  
                    x=891,
                    y=340.5000000000001,
                    width=606.0097219515271,
                    height=606.0097219515271,
                    attributes=list(list()))

tree_g$attributes = list(list(
  strokeColor = "#2b8a3e",
  backgroundColor = "#40c057",
  fillStyle = "cross-hatch", points = tree))

att <- tree_g %>% unnest_wider(attributes)
a$add(invoke(miniexcali::g_element, att))

## add garlands
pts <- gly_glyph(type = 'ellipse',
                 x = tree[,1] + 891, 
                 y = tree[,2] + 340.5000000000001, 
                 width = runif(nrow(tree), 10, 20), 
                 height = runif(nrow(tree), 10, 20), 
                 attributes = lapply(1:nrow(tree), function(ii)
                   list(fillStyle = if(ii%%2) "hachure" else "solid", 
                        strokeWidth = 1L,
                        backgroundColor = sample(size = 1, hcl(seq(0,360))))))


invoke(a$add, pmap(pts %>% unnest_wider(attributes),
                   miniexcali::g_element))


## get nodes of text shapes
library(gridfont)
let <- create_text_df('merry_christmas')

llet <- split(let, let$char_idx)

scale <- 25
offset_x <- 100
offset_y <- 400

for(l in llet){
  col <- sample(size = 1, hcl(seq(0,360), c = 50, l=70))
  new_let <- gly_glyph(type = 'line',  
                       x=scale*max(l$xoffset)-offset_x,
                       y=scale*min(10 - l$y)-offset_y,
                       width=diff(scale*range(l$x)),
                       height=diff(scale*range(l$y)),
                       attributes=list(list(roughness=2)))
  
  xy <- cbind(scale*l$x, scale*(10 - l$y))
  xy[,1] <- xy[,1] - min(xy[,1])
  xy[,2] <- xy[,2] - min(xy[,2])
  new_let$attributes = list(list(strokeWidth = 1L,
                                 roughness=2L,
                                 strokeColor = col,
                                 strokeSharpness= "round",
                                 backgroundColor = "#40c057",
                                 fillStyle = "cross-hatch", 
                                 points = xy))
  
  att <- new_let %>% unnest_wider(attributes)
  a$add(invoke(miniexcali::g_element, att))
  
  r <- runif(nrow(xy), 5, 15)
  pts <- gly_glyph(type = 'ellipse',
                   x = scale*max(l$xoffset)+xy[,1] - 0.5*r-offset_x, 
                   y = scale*min(10 - l$y) + xy[,2] - 0.5*r-offset_y, 
                   width = r, 
                   height = r, 
                   attributes = lapply(1:nrow(xy), function(ii)
                     list(fillStyle =  "cross-hatched", 
                          strokeWidth = 0L,
                          backgroundColor = sample(size = 1, hcl(seq(0,360))))))
  

  invoke(a$add, pmap(pts %>% unnest_wider(attributes),
                     miniexcali::g_element))

  
}


## add kevin and roberto

scale <- 1
for(l in .roberto){
  new_stroke <- gly_glyph(type = 'line',  
                       x=scale*l$x,
                       y=scale*l$y,
                       width=scale*l$width,
                       height=scale*l$height,
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
  a$add(invoke(miniexcali::g_element, att))
  
}


scale <- 1
for(l in .kevin){
  new_stroke <- gly_glyph(type = 'line',  
                          x=scale*l$x,
                          y=scale*l$y,
                          width=scale*l$width,
                          height=scale*l$height,
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
  a$add(invoke(miniexcali::g_element, att))
  
}

a$export('strip.json')

# https://excalidraw.com/#json=6272303994241024,yokUkJYuUO4Sgl8TpXSbQw


