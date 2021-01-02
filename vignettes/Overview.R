## ----setup, echo=FALSE, message=FALSE,warning=FALSE,out.width='100%'----------
library(minixcali)
library(purrr)
library(knitr)
opts_chunk$set(message = FALSE, 
               warning=FALSE,
               fig.width = 7,
               fig.height = 3, 
               out.width='100%')

knitr::include_graphics('overview.png')

## ---- eval=FALSE--------------------------------------------------------------
#  list(type = "rectangle",
#       x = -407.242554, y = 0,
#       width = 44, height = 44,
#       angle = 0,
#       strokeColor = "#495057",
#       backgroundColor = "#ced4da",
#       fillStyle = "hachure",
#       strokeWidth = 1,
#       strokeStyle = "solid",
#       roughness = 1L,
#       opacity = 100L,
#       strokeSharpness = "sharp",
#       isDeleted = FALSE,
#       groupIds = list(),
#       boundElementIds = NA,
#       id = "2732dc14872d3709d5978813d7bf550c",
#       seed = 1260353516L,
#       version = 32L,
#       versionNonce = 784119031L)

## ----test_shape, eval=TRUE----------------------------------------------------
str(xkd_text(text = "new label", 
             strokeColor = "#555555"))

## ----iterate, eval=TRUE-------------------------------------------------------
a <- tribble(~x, ~y, ~width, ~height, ~roughness, ~backgroundColor,
             -300 ,   -80,   300,    300, 0, "#ced4da",
             10 ,   -80,   300,    300, 1, "#ced4da",
             320 ,   -80,   300,    300, 2, "#ced4da")

a$strokeWidth <- 2

d <- Excali_doc()
invoke(d$add, pmap(a, minixcali::xkd_rectangle))
str(d$elements, max.level = 1)

## ----export, out.width="100%", echo=1-----------------------------------------
d$export(file='testing.json')
knitr::include_graphics('testing.png')

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

