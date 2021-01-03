## ----setup, echo=FALSE, message=FALSE,warning=FALSE,out.width='100%'----------
library(minixcali)
library(purrr)
library(knitr)
opts_chunk$set(message = FALSE, 
               warning=FALSE,
               fig.width = 7,
               fig.height = 4, 
               out.width='50%')


## ---- fig.width = 3, fig.height = 3-------------------------------------------
library(minixcali)
library(ggplot2)
library(gridExtra)
library(dplyr)

x=seq(-1,2,length=200); y=seq(-1,2,length=200)
x2=seq(-0.87,1.8,length=30); y2=seq(-0.87,1.8,length=30)
xy <- expand.grid(x=x, y=y)
xy2 <- expand.grid(x=x2, y=y2)

model <- function(q = c(1,-1), x0=c(0, 1), y0=c(0,1), xy){
  E <- Ex <- Ey <- V <- 0
  for(ii in seq_along(q)){
    V = V + q[ii] * log((xy$x - x0[ii])^2 + (xy$y - y0[ii])^2)
    E =  E + q[ii] * (atan2((xy$y - y0[ii]), (xy$x - x0[ii])))
    Ex = Ex + (xy$x - x0[ii]) / ((xy$x - x0[ii])^2 + (xy$y - y0[ii])^2)^(1)
    Ey = Ey + (xy$y - y0[ii]) / ((xy$x - x0[ii])^2 + (xy$y - y0[ii])^2)^(1)
  }
  
  mutate(xy, V=V, E=E, Ex=Ex, Ey=Ey)
}

test <- model(q = c(5,-6, 3,-2), x0=c(0, 1, 1.5, 0.5), y0=c(0,1, 0.8, 0.5), xy=xy)

test2 <- model(q = c(5,-6, 3,-2), x0=c(0, 1, 1.5, 0.5), y0=c(0,1, 0.8, 0.5), xy=xy2)


charges <- data.frame(q = c(5,-6, 3,-2), 
                      x=c(0, 1, 1.5, 0.5), 
                      y=c(0,1, 0.8, 0.5), 
                      col = range(test$V, finite=TRUE)[c(1,2, 1,2)])

p <- ggplot(data = test, aes(x,y)) + 
  geom_raster(aes(fill=V)) +
  geom_contour(aes(z=V,colour=V), bins = 20) +
  geom_point(data=charges, aes(colour=col, size=abs(q))) +
  geom_segment(data=test2, aes(x=x,y=y,
                               xend=x+Ex/50,yend=y+Ey/50,colour=V)) +
  scale_fill_gradient2() +
  scale_colour_gradient2() +
  guides(fill="none",colour="none",size="none") +
  theme_void() + coord_equal()

p

## ----data---------------------------------------------------------------------

gb <- ggplot_build(p)
str(gb$data[[4]])

tr <- gb$data[[4]]
b <- split(tr, seq(1,nrow(tr)))
str(b, list.len = 3)

## ----fun----------------------------------------------------------------------
d <- Excali_doc()

library(scales)

scale <- 100

for (ii in seq_along(b)) {
  s <- b[[ii]]
  
  m <- scale * cbind(c(0,s$xend),c(0,-s$yend))
  
  shape <- xkd_arrow(
    x = scale * s$x,
    y =  scale * s$y,
    width = scale ,
    height = scale ,
    strokeWidth = 2,
    roughness = 0L,
    strokeSharpness = "sharp",
    groupIds = list("levelplot",
                    paste0('level-', ii)),
    fillStyle = "solid",
    strokeColor = s$colour[1],
    backgroundColor = s$colour[1],
    points = m)
  
  d$add(shape)
  
}

d$export('arrow.json')

## ----drawing, out.width="50%", fig.align='center', echo=FALSE-----------------
knitr::include_graphics('tree.png')

