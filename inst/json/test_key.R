

library(minixcali)
library(jsonlite)
library(tibble)
library(tidyr) # v list-columns
library(magrittr)
library(purrr)
library(tidyr)
d <- structure(list(text = c("Q", "W", "E", "R", "T", "Y", "U", 
                               "I", "O", "P", "A", "S", "D", "F", "G", "H", "J", "K", "L", "Z", 
                               "X", "C", "V", "B", "N", "M"), x = c(-203.621277, -175.909286, 
                                                                    -143.248291, -114.546295, -83.864792, -54.172974, -24.481201, 
                                                                    8.179996, 33.913033, 64.594307, -195.704285, -165.022293, -136.320297, 
                                                                    -105.63829, -76.9366, -47.244781, -15.573486, 12.138889, 42.820618, 
                                                                    -183.827286, -154.135284, -124.443298, -94.752289, -65.059998, 
                                                                    -35.367798, -6.665894), y = c(-8.6117767, -8.6117767, -8.6117767, 
                                                                                                  -8.6117767, -8.6117767, -8.6117767, -8.6117767, -8.6117767, -8.6117767, 
                                                                                                  -8.6117767, -11.1813965, -11.1813965, -11.1813965, -11.1813965, 
                                                                                                  -11.1813965, -11.1813965, -11.1813965, -11.1813965, -11.1813965, 
                                                                                                  -13.6521866, -13.6521866, -13.6521866, -13.6521866, -13.6521866, 
                                                                                                  -13.6521866, -13.6521866), highlight = c(FALSE, FALSE, TRUE, 
                                                                                                                                           TRUE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, TRUE, FALSE, TRUE, 
                                                                                                                                           FALSE, FALSE, FALSE, FALSE, TRUE, FALSE, FALSE, FALSE, FALSE, 
                                                                                                                                           FALSE, TRUE, FALSE, FALSE)), row.names = c(NA, -26L), class = c("tbl_df", 
                                                                                                                                                                                                           "tbl", "data.frame"))


att <- d[,1:3]
att$x <- 2*d$x 
att$y <- 20*(-d$y + max(d$y))
att$width <- 44
att$height <- 44
att$type <- 'rectangle'

att2 <- att
att2$x <- att$x + 16
att2$y <- att$y + 12
att2$type <- 'text'
att2$fontSize <- 20
att2$fontFamily <- 1
att2$textAlign <- "left"
att2$verticalAlign <- "top"
att2$baseline <- 18

a <- Excali_doc()
invoke(a$add, pmap(att, minixcali::g_element))
invoke(a$add, pmap(att2, minixcali::g_element))

a$export('key.json')
