
gly_glyph <- function(type,
                      x, y, 
                      width, height, 
                      attributes = list()){
  tb <- tibble::tibble(type = type, 
                       x = x, y = y, 
                       width = width, height = height)
  tb$attributes <- attributes
  tb
}


