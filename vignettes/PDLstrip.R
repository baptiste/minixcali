## ----setup, echo=FALSE, message=FALSE,warning=FALSE,out.width='100%'----------
library(minixcali)
library(purrr)
library(knitr)
opts_chunk$set(message = FALSE, 
               warning=FALSE,
               fig.width = 7,
               fig.height = 3, 
               out.width='100%')

## ----kevin--------------------------------------------------------------------
str(.kevin) # stored coords in the package under data/

d <- Excali_doc()

for (l in .kevin) {
  call <- c(l,
    list(
      groupIds = list(list("kevin")),
      strokeSharpness = "round",
      fillStyle = "solid",
      strokeWidth = 1L,
      roughness = 0L
    )
  )
  
  shape <- invoke(xkd_draw, call)
  d$add(shape)
  
}

d$export('drawing.json')

## ----kevindrawing, out.width="40%", fig.align='center', echo=FALSE------------
knitr::include_graphics('kevin.png')

