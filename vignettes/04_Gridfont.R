## ----setup, echo=FALSE, message=FALSE,warning=FALSE,out.width='100%'----------
library(minixcali)
library(purrr)
library(knitr)
opts_chunk$set(message = FALSE, 
               warning=FALSE,
               fig.width = 7,
               fig.height = 4, 
               out.width='50%')


## ---- fig.width = 3, fig.height = 5-------------------------------------------
library(minixcali)
library(gridfont)
let <- create_text_df('merry_christmas')
llet <- split(let, let$char_idx)

## ----data---------------------------------------------------------------------
str(llet, list.len = 4)

## ----fun----------------------------------------------------------------------


d <- Excali_doc()

scale <- 25
offset_x <- 100
offset_y <- 400

for (l in llet) {
  col <- sample(size = 1,
                hcl(seq(0, 360), c = 50, l = 70))
  
  xy <- cbind(scale * l$x, scale * (10 - l$y))
  xy[, 1] <- xy[, 1] - min(xy[, 1])
  xy[, 2] <- xy[, 2] - min(xy[, 2])
  
  
  stroke <- xkd_draw(
    x = scale * max(l$xoffset) - offset_x,
    y = scale * min(10 - l$y) - offset_y,
    width = diff(scale * range(l$x)),
    height = diff(scale * range(l$y)),
    strokeWidth = 1L,
    roughness = 2L,
    strokeColor = col,
    strokeSharpness = "round",
    backgroundColor = "#40c057",
    fillStyle = "hachure",
    points = xy
  )
  
  d$add(stroke)
  
  for (ii in seq(1, nrow(xy))) {
    r <- runif(1, 5, 15)
    point <- xkd_ellipse(
      x = scale * max(l$xoffset[ii]) + xy[ii, 1] -
        0.5 * r - offset_x,
      y = scale * min(10 - l$y) + xy[ii, 2] -
        0.5 * r - offset_y,
      width = r,
      height = r,
      roughness = 2L, 
    strokeSharpness = "sharp",
      fillStyle =  "solid",
      strokeWidth = 0.5,
      backgroundColor = sample(size = 1, 
                               hcl(seq(0, 360)))
    )
    
    d$add(point)
  }
  
  
}

d$export('gridfont.json')

## ----drawing, out.width="100%", fig.align='center', echo=FALSE----------------
knitr::include_graphics('gridfont.png')

