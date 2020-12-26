library(minixcali)
library(isoband)

m <- volcano
b <- isobands((1:ncol(m))/(ncol(m)+1), (nrow(m):1)/(nrow(m)+1), m, 10*(9:19), 10*(10:20))

str(b)


d <- Excali_doc()

library(scales)


# fills <- terrain.colors(length(b), alpha = 0.5)
# cols <- terrain.colors(length(b), alpha = 1)
fills <- scales::viridis_pal(alpha = 0.5)(length(b))
cols <- scales::viridis_pal(alpha = 1)(length(b))

scale <- 500

for(ii in seq_along(b)){
  fill <- fills[ii]
  col <- cols[ii]
  
  l <- b[[ii]]
  spl <- split(data.frame(x=l$x,y=-l$y), l$id)
  
  for (s in spl){
    
    r_x <- range(s$x)
    r_y <- range(s$y)
    
    m <- scale*cbind(s$x - r_x[1], s$y - r_y[1])
    
    shape <- list(type='draw',
                  x = scale*r_x[1],
                  y=  scale*r_y[1],
                  width = scale*diff(r_x),
                  height = scale*diff(r_y),
                  strokeWidth = 0.5,
                  roughness=1L,
                  strokeSharpness= "round",
                  groups = c(paste0('level-',ii)),
                  fillStyle = "cross-hatch",
                  strokeColor = col,
                  backgroundColor = fill)
    shape$points <- list(m) 
    
    d$add(invoke(minixcali::g_element, shape))
  }
}

d$export('isoband.json')
