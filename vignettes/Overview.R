## ----setup, echo=FALSE, results='hide', message=FALSE-------------------------
library(minixcali)
library(purrr)
library(knitr)
opts_chunk$set(message = FALSE,
               fig.width = 7,
               fig.height = 3)

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

## ----iterate, eval=TRUE-------------------------------------------------------
a <- tribble(~x, ~y, ~width, ~height, ~roughness, ~backgroundColor,
             -156 ,   -80,   400,    300, 0, "#f7fdff",
             262 ,   -80,   400,    300, 1, "#f7fdff",
             -156 ,   240,   400,    300, 2, "#f7fdff",
             263.,   240,   400,    300, 2, "#f7fdff")

d <- Excali_doc()
invoke(d$add, pmap(a, minixcali::g_element))
str(d$elements)

