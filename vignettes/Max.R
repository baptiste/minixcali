## ----setup, echo=FALSE, message=FALSE,warning=FALSE,out.width='100%'----------
library(minixcali)
library(purrr)
library(svgchop)

b <- chop('max.svg', steps = 10, transform = TRUE)[[1]]
names(b)

fl <- readLines('max.svg')

use <- grep("^<use ", fl, value = TRUE)
spl <- strsplit(use, ' ')
x <- vapply(spl, function(x) as.numeric(gsub("'|x=","",x[2])), 1.0)
y <- vapply(spl, function(x) as.numeric(gsub("'|y=|/>","",x[4])), 1.0)
link <- paste0('path',vapply(spl, function(x) gsub("'|xlink:href=","",x[3]), 'a'))

glyphs <- lapply(link, function(name) list(name = name))

for(n in seq_along(glyphs)){
  id <- which(names(b) == link[n])
  glyphs[[n]][['points']] <- b[[id]]
  glyphs[[n]][['x']] <- x[n]
  glyphs[[n]][['y']] <- y[n]
}


d <- Excali_doc()

scale <- 10

for (ii in seq_along(glyphs)) {
  
  b <- glyphs[[ii]]
  r_x <- range(b$points[1, ])
  r_y <- range(b$points[2, ])
  brks <- cumsum(abs(c(0, diff(b$points[1,]))) > 0.2 * abs(diff(r_x)) |
                   abs(c(0, diff(b$points[2,]))) > 0.2 * abs(diff(r_y)))
  df <- data.frame(x = b$points[1, ],
                   y = b$points[2, ],
                   g = brks)
  ls <- split(df, df$g)
  
  for(s in ls){
    
    s_x <- range(s$x)
    s_y <- range(s$y)
    
    m <- scale * cbind(s$x - s_x[1], 
                       s$y - s_y[1])
    
    shape <- xkd_draw(
      x = scale * (b$x + s_x[1]),
      y =  scale * (b$y + s_y[1]),
      width = scale * diff(s_x),
      height = scale * diff(s_y),
      strokeWidth = 1,
      roughness = 0L,
      strokeSharpness = "sharp",
      groupIds = list("letter", paste0('part',unique(s$g))),
      fillStyle = "solid",
      strokeColor = '#000000',
      backgroundColor = '#000000',
      points = m)
    
    d$add(shape)
  }
  
}

d$export('max.json')

