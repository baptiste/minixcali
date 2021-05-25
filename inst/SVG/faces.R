library(minixcali)
# remotes::install_github('brodieG/svgchop')
library(svgchop)

setwd("~/Documents/github/minixcali/inst/SVG")
# b <- chop('inst/json/fun.svg', steps=3)[[1]]
b <- svgchop::chop('faces.svg', steps=2)
a <- flatten(b)

plot(a)
str(a)


d <- Excali_doc()

library(scales)

scale <- 0.1

for(ii in seq_along(a)){
  
  col <- '#0b7285'
  fill <- '#0b7285'
  
  s <- a[[ii]]
  
    
    r_x <- range(s[1,])
    r_y <- range(s[2,])
    
    m <- scale*cbind(s[1,] - r_x[1], s[2,] - r_y[1])
    
    shape <- xkd_draw(
                  x = scale*r_x[1],
                  y=  scale*r_y[1],
                  width = scale*diff(r_x),
                  height = scale*diff(r_y),
                  strokeWidth = 0.5,
                  roughness=0L,
                  strokeSharpness= "round",
                  groupIds = c("id",paste0('s-',ii)),
                  fillStyle = "solid",
                  backgroundColor = fill,
                  strokeColor = col,
                  points = m) 
    
    d$add(shape)
  
}

d$export('faces.json')
