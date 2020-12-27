library(minixcali)
library(flametree)
library(ggplot2)

dat <- flametree_grow(seed = 4, time = 10) # data structure
img <- flametree_plot(tree = dat)          # ggplot object

gb <- ggplot_build(img)

tr <- gb$data[[1]]
b <- split(tr, tr$group)
str(b)


d <- Excali_doc()

library(scales)


# fills <- terrain.colors(length(b), alpha = 0.5)
# cols <- terrain.colors(length(b), alpha = 1)
# fills <- scales::viridis_pal(alpha = 0.2)(length(b))
# cols <- scales::viridis_pal(alpha = 1)(length(b))

scale <- 100

for(ii in seq_along(b)){

  s <- b[[ii]]
  # spl <- split(l, l$colour)
  
  # for (s in spl){
    
    r_x <- range(s$x)
    r_y <- range(s$y)
    
    m <- scale*cbind(s$x - r_x[1], -s$y - r_y[1])
    
    shape <- list(type='draw',
                  x = scale*r_x[1],
                  y=  scale*r_y[1],
                  width = scale*diff(r_x),
                  height = scale*diff(r_y),
                  strokeWidth = 1,
                  roughness=0L,
                  strokeSharpness= "round",
                  groups = c("levelplot",paste0('level-',ii)),
                  fillStyle = "solid",
                  strokeColor = s$colour[1],
                  backgroundColor = (s$colour[1]))
    shape$points <- list(m) 
    
    d$add(invoke(minixcali::g_element, shape))
  # }
}

d$export('tree.json')
