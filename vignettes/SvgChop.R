## ----setup, echo=FALSE, message=FALSE,warning=FALSE,out.width='100%'----------
library(minixcali)
library(purrr)
library(knitr)
opts_chunk$set(message = FALSE, 
               warning=FALSE,
               fig.width = 7,
               fig.height = 3, 
               out.width='100%')


## ----input, out.width="100%", fig.align='center', echo=FALSE------------------
knitr::include_graphics(system.file('svgs/fun.svg', package='minixcali'))

## ----svgchop------------------------------------------------------------------
# remotes::install_github('brodieG/svgchop')
library(svgchop)

b <- chop('fun.svg', steps = 3)[[1]]

str(b, max.level = 1, 
    give.attr = FALSE, list.len = 3)
str(b[[1]])

## ----fun----------------------------------------------------------------------
d <- Excali_doc()

library(scales)

cols <- hcl(seq(0, 360, length = length(b)))

scale <- 0.5

for (ii in seq_along(b)) {
  col <- cols[ii]
  s <- b[[ii]]
  
  r_x <- range(s[1, ])
  r_y <- range(s[2, ])
  
  m <- scale * cbind(s[1, ] - r_x[1], 
                     s[2, ] - r_y[1])
  
  shape <- xkd_draw(
    x = scale * r_x[1],
    y =  scale * r_y[1],
    width = scale * diff(r_x),
    height = scale * diff(r_y),
    strokeWidth = 0.5,
    roughness = 0L,
    strokeSharpness = "round",
    groupIds = list("levelplot", 
                    paste0('level-', ii)),
    fillStyle = "solid",
    strokeColor = col,
    points = m)
  
  d$add(shape)
  
}

d$export('fun.json')

## ----drawing, out.width="100%", fig.align='center', echo=FALSE----------------
knitr::include_graphics('fun.png')

