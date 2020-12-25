

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
j <- jsonlite::read_json('json/multi.json', simplifyVector = FALSE)

xs <- vapply(j$elements, "[[",'x', FUN.VALUE = pi)
ys <- vapply(j$elements, "[[",'y', FUN.VALUE = pi)
ws <- vapply(j$elements, "[[",'width', FUN.VALUE = pi)
hs <- vapply(j$elements, "[[",'height', FUN.VALUE = pi)

rs <- gly_glyph(type = c('rectangle','rectangle','rectangle','ellipse'),
                x = xs, y = ys, 
                width = ws, height = hs, 
                attributes = lapply(seq_along(xs), function(ii)
                  list(fillStyle = dplyr::case_when(ii==1 ~ "hachure",
                                             ii==2 ~ "solid", 
                                             ii==3 ~ "solid", TRUE ~ "cross-hatch"),
                       strokeWidth = 2L)))

rs[2,]$attributes[[1]] <- append(rs[2,]$attributes[[1]], 
                                 list(roughness=2))

rs[3,]$attributes[[1]] <- append(rs[3,]$attributes[[1]], 
                                 list(roughness=1,
                                      backgroundColor = '#fafafb'))

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

tree <- matrix(c(69.400466272227, 81.2830098399034, 78.3123739479842, 18.8996561095993, 
                 -82.1019642156554, -143, -132.602774378283, -96.9551436752517, 
                 15.92902021768, 79.797691893944, 84.2536457318228, 75.3417380560649, 
                 27.8115637853572, -31.601154053028, -55.3662411883821, -55.3662411883819, 
                 -80.6166462696957, -80.6166462696956, -50.9102873505031, -33.0864719989877, 
                 -18.2332925393913, 4.04647665000317, 17.4143381636399, 79.7976918939442, 
                 85.7389636777825, 85.738963677782, 14.4437022717207, -3.38011307979536, 
                 -3.38011307979497, -1.89479513383557, 2.56115870404352, 11.4730663798011, 
                 57.5179227045494, 82.7683277858629, 127.327866164652, 151.092953300006, 
                 155.548907137885, 223.873532652028, 266.947753084857, 308.536655571726, 
                 308.536655571727, 305.566019679807, 280.315614598494, 203.079081408593, 
                 185.255266057078, 246.153301841422, 275.859660760615, 338.24301449092, 
                 353.096193950515, 364.978737518192, 372.40532724799, 393.199778491425, 
                 412.5089117889, 402.111686167183, 387.258506707586, 222.388214706068, 
                 222.388214706068, 186.740584003037, 183.769948111118, 183.769948111118, 
                 206.049717300512, 214.96162497627, 217.932260868189, 238.726712111623, 
                 259.521163355059, 326.360470923242, 344.184286274757, 367.949373410111, 
                 397.655732329304, 449.641860437891, 463.009721951527, 445.185906600012, 
                 434.788680978294, 411.02359384294, 403.597004113142, 250.609255679301, 
                 154.063589191925, 149.607635354046, 155.548907137885, 152.578271245966, 
                 155.548907137885, 154.063589191926, 67.915148326267, 66.4298303803072, 
                 70.8857842181859, 69.400466272227, 178.417926632589, 57.503872846536, 
                 53.1855137827485, 47.4277016976984, 60.3827788890609, 81.9745742079993, 
                 60.382778889061, 21.5175473149725, -64.8496339607795, -93.6386943860301, 
                 -103.714865534868, -109.472677619918, -110.91213064118, -99.3965064710803, 
                 -86.4414292797175, -85.0019762584549, -95.0781474072926, -106.593771577393, 
                 -136.822285023906, -151.216815236532, -169.929704512945, -181.445328683045, 
                 -182.884781704307, -228.947278384709, -240.462902554809, -253.417979746172, 
                 -256.296885788696, -260.615244852484, -270.691416001321, -270.691416001322, 
                 -280.767587150159, -290.843758298997, -328.269536851823, -339.785161021924, 
                 -374.332033532224, -406, -406, -310.996100596672, -276.449228086371, 
                 -254.857432767434, -249.099620682384, -244.781261618596, -237.583996512284, 
                 -234.705090469759, -231.826184427233, -201.59767098072, -195.83985889567, 
                 -169.929704512943, -168.490251491683, -162.732439406632, -155.535174300319, 
                 -141.140644087693, -109.472677619918, -102.275412513606, -97.9570534498185, 
                 -97.9570534498182, -96.5176004285556, -95.0781474072924, -99.3965064710803, 
                 -96.5176004285554, -70.6074460458297, -64.8496339607795, -59.0918218757292, 
                 -49.0156507268917, -44.6972916631036, -14.4687782165906, -4.39260706775343, 
                 -1.51370102522816, 7.12301710234738, 41.6698896126486, 57.5038728465354, 
                 71.8984030591616, 77.6562151442112, 79.0956681654735, 76.2167621229488, 
                 74.7773091016861, 64.7011379528484, 94.929651399362, 119.400352760825, 
                 153.947225271126, 187.054644760164, 194.251909866477, 200.009721951527, 
                 184.175738717639, 175.539020590064, 178.417926632589), ncol=2, byrow = FALSE)

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

a$export('strip.json')

# https://excalidraw.com/#json=6272303994241024,yokUkJYuUO4Sgl8TpXSbQw


