library(minixcali)
# remotes::install_github('brodieG/svgchop')
library(svgchop)


# b <- chop('inst/json/fun.svg', steps=3)[[1]]
b <- chop('inst/json/nz.svg', steps=1)

str(b[[1]])

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

scale <- 5

for(ii in seq_along(b)){
  
  # col <- '#000000'
  col <- attr(b[[ii]],'style-computed')$stroke
  fill <- attr(b[[ii]],'style-computed')$fill
  
  s <- b[[ii]]
  
    
    r_x <- range(s[1,])
    r_y <- range(s[2,])
    
    m <- scale*cbind(s[1,] - r_x[1], s[2,] - r_y[1])
    
    shape <- list(type='draw',
                  x = scale*r_x[1],
                  y=  scale*r_y[1],
                  width = scale*diff(r_x),
                  height = scale*diff(r_y),
                  strokeWidth = 0.5,
                  roughness=0L,
                  strokeSharpness= "round",
                  groups = c("levelplot",paste0('level-',ii)),
                  fillStyle = "solid",
                  backgroundColor = fill,
                  strokeColor = col)
    shape$points <- list(m) 
    
    d$add(invoke(minixcali::g_element, shape))
  
}

d$export('nz.json')
