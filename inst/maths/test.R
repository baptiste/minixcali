library(minixcali)

d <- Excali_doc()
shape <- xkd_rectangle(width = 300, height=200,
                       fillStyle = 'hachure', roughness = 2)
math <- xkd_math(text = "\\alpha\\approx \\frac\\pi 2")
d$add(shape)
d$add(math)
d$export(file='rect_new.excalidraw')
