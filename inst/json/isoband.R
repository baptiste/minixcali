library(minixcali)
library(isoband)

m <- volcano
b <- isobands((1:ncol(m))/(ncol(m)+1), (nrow(m):1)/(nrow(m)+1), m, 10*(9:19), 10*(10:20))
# 
# library(rayshader)
# 
# #Here, I load a map with the raster package.
# loadzip = tempfile()
# download.file("https://tylermw.com/data/dem_01.tif.zip", loadzip)
# localtif = raster::raster(unzip(loadzip, "dem_01.tif"))
# unlink(loadzip)
# 
# #And convert it to a matrix:
# elmat = raster_to_matrix(localtif)
# 
# 
# m <- elmat
# range(elmat)
# 
# b <- isobands((1:ncol(m))/(ncol(m)+1), (nrow(m):1)/(nrow(m)+1), m, seq(0,900,by=80), seq(50,950,by=80))

str(b)


d <- Excali_doc()

library(scales)


# fills <- terrain.colors(length(b), alpha = 0.5)
# cols <- terrain.colors(length(b), alpha = 1)
fills <- scales::viridis_pal(alpha = 0.2)(length(b))
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
                  strokeWidth = 0.8,
                  roughness=2L,
                  strokeSharpness= "round",
                  groups = c("levelplot",paste0('level-',ii)),
                  fillStyle = "solid",
                  strokeColor = col,
                  backgroundColor = fill)
    shape$points <- list(m) 
    
    d$add(invoke(minixcali::g_element, shape))
  }
}

d$export('volcano.json')
