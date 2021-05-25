library(minixcali)
# remotes::install_github('brodieG/svgchop')
library(svgchop)

setwd("~/Documents/github/minixcali/inst/svgs")
# b <- chop('inst/json/fun.svg', steps=3)[[1]]
b <- svgchop::chop('trump.svg', steps=10)

str(b[[2]])

# d <- data.frame(x=b[[1]][1,], y = b[[1]][2,])
# brks <- c(FALSE, abs(diff(d$x)) > 1000)
# d$levs <- cumsum(brks)
# b <- split(d, d$levs)
# plot(d[2,])
# abline(v=which(brks))

d <- Excali_doc()

library(scales)


# fills <- terrain.colors(length(b), alpha = 0.5)
# cols <- terrain.colors(length(b), alpha = 1)
# fills <- scales::viridis_pal(alpha = 0.2)(length(b))
# cols <- scales::viridis_pal(alpha = 1)(length(b))
# cols <- hcl(seq(0,360, length=length(b)))

scale <- 0.5

for(ii in seq_along(b[-length(b)])){
  
  # col <- '#000000'
  col <- 'black'
  fill <- 'none'
  
  s <- b[[ii]]
  
    
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
                  groupIds = c("levelplot",paste0('level-',ii)),
                  fillStyle = "solid",
                  backgroundColor = fill,
                  strokeColor = col,
                  points = m) 
    
    d$add(shape)
  
}

d$export('trump.json')
