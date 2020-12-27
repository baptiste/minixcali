library(minixcali)
# remotes::install_github('brodieG/svgchop')
library(svgchop)


# b <- chop('inst/json/fun.svg', steps=3)[[1]]
b <- chop('inst/json/wat.svg', steps=3)[[1]]

str(b[[1]])


d <- Excali_doc()

library(scales)


# fills <- terrain.colors(length(b), alpha = 0.5)
# cols <- terrain.colors(length(b), alpha = 1)
# fills <- scales::viridis_pal(alpha = 0.2)(length(b))
cols <- scales::viridis_pal(alpha = 1)(length(b))
# cols <- hcl(seq(0,360, length=length(b)))

scale <- 1

for(ii in seq_along(b)){
  
  col <- cols[ii]
  
  s <- b[[ii]]
  
    
    r_x <- range(s[1,])
    r_y <- range(s[2,])
    
    m <- scale*cbind(s[1,] - r_x[1], s[2,] - r_y[1])
    
    shape <- list(type='draw',
                  x = scale*r_x[1],
                  y=  scale*r_y[1],
                  width = scale*diff(r_x),
                  height = scale*diff(r_y),
                  strokeWidth = 2,
                  roughness=0L,
                  strokeSharpness= "round",
                  groups = c("levelplot",paste0('level-',ii)),
                  fillStyle = "solid",
                  strokeColor = col)
    shape$points <- list(m) 
    
    d$add(invoke(minixcali::g_element, shape))
  
}

d$export('wat.json')
