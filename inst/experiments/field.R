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
  theme_map() + coord_equal()

p
gb <- ggplot_build(p)
str(gb$data[[4]])


