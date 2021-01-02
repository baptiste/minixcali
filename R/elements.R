set.seed(123)
.seeds <- .Random.seed[-1]


#' @title xkd_rectangle
#' @inheritParams xkd_element
#' @export
xkd_rectangle <- function(x = 0.0,
                          y = 0.0,
                          width = 100,
                          height = 100,
                          angle = 0L,
                          strokeColor = "#000000",
                          backgroundColor = "#868e96",
                          fillStyle = c("solid",
                                        "hachure",
                                        "cross-hatch"),
                          strokeWidth = 2L,
                          strokeStyle = c("solid",
                                          "dashed",
                                          "dotted"),
                          roughness = 0L,
                          opacity = 100L,
                          groupIds = list(),
                          strokeSharpness = c("sharp","round"),
                          isDeleted = FALSE,
                          boundElementIds = NA,
                          version = 1,
                          versionNonce = 12345) {
  
  type = 'rectangle'
  
  fillStyle = match.arg(fillStyle)
  strokeStyle = match.arg(strokeStyle)
  strokeSharpness = match.arg(strokeSharpness)
  
  new_elem <- as.list(environment())
  
  # hashing the element to make a unique ID
  drop <- names(new_elem) %in% c('version', 'versionNonce')
  new_elem$id =  digest::digest(new_elem[!drop],
                                algo = "md5")
  
  # assign random seed
  new_elem$seed = abs(sample(.seeds, 1))
  
  new_elem
}



#' @title xkd_ellipse
#' @inheritParams xkd_element
#' @export
xkd_ellipse <- function(x = 0.0,
                        y = 0.0,
                        width = 100,
                        height = 100,
                        angle = 0L,
                        strokeColor = "#000000",
                        backgroundColor = "#868e96",
                        fillStyle = c("solid",
                                      "hachure",
                                      "cross-hatch"),
                        strokeWidth = 2L,
                        strokeStyle = c("solid",
                                        "dashed",
                                        "dotted"),
                        roughness = 0L,
                        opacity = 100L,
                        groupIds = list(),
                        strokeSharpness = c("sharp","round"),
                        isDeleted = FALSE,
                        boundElementIds = NA,
                        version = 1,
                        versionNonce = 12345) {
  type = 'ellipse'
  
  fillStyle = match.arg(fillStyle)
  strokeStyle = match.arg(strokeStyle)
  strokeSharpness = match.arg(strokeSharpness)
  
  new_elem <- as.list(environment())
  
  # hashing the element to make a unique ID
  drop <- names(new_elem) %in% c('version', 'versionNonce')
  new_elem$id =  digest::digest(new_elem[!drop],
                                algo = "md5")
  
  # assign random seed
  new_elem$seed = abs(sample(.seeds, 1))
  
  new_elem
}


#' @title xkd_draw
#' @inheritParams xkd_element
#' @param points of glyph
#' @param lastCommittedPoint of glyph
#' @param startBinding of glyph
#' @param endBinding of glyph
#' @param startArrowhead of glyph
#' @param endArrowhead of glyph
#' @export
xkd_draw <- function(x = 0,
                     y = 0,
                     width = 100,
                     height = 100,
                     angle = 0L,
                     strokeColor = "#000000",
                     backgroundColor = "#868e96",
                     fillStyle = c("solid",
                                   "hachure",
                                   "cross-hatch"),
                     strokeWidth = 1L,
                     strokeStyle = c("solid",
                                     "dashed",
                                     "dotted"),
                     roughness = 0L,
                     opacity = 100L,
                     groupIds = list(),
                     strokeSharpness = c("round",
                                         "sharp"),
                     isDeleted = FALSE,
                     boundElementIds = NA,
                     points = list(list(0L, 0L),
                                   list(100, 0L)),
                     lastCommittedPoint = NA,
                     startBinding = NA,
                     endBinding = NA,
                     startArrowhead = NA,
                     endArrowhead = NA,
                     version = 1,
                     versionNonce = 12345) {
  type = 'draw'
  
  fillStyle = match.arg(fillStyle)
  strokeStyle = match.arg(strokeStyle)
  strokeSharpness = match.arg(strokeSharpness)
  
  new_elem <- as.list(environment())
  
  # hashing the element to make a unique ID
  drop <- names(new_elem) %in% c('version', 'versionNonce')
  new_elem$id =  digest::digest(new_elem[!drop],
                                algo = "md5")
  
  # assign random seed
  new_elem$seed = abs(sample(.seeds, 1))
  
  new_elem
}

#' @title xkd_text
#' @inheritParams xkd_element
#' @param text text string
#' @param fontSize in pts
#' @param fontFamily 1, 2, 3 (FG_Virgil,Cascadia,?)
#' @param textAlign "left", "center", "right"
#' @param verticalAlign "bottom", "center", "top"
#' @param baseline offset in pts?
#' @export
xkd_text <- function(x = 0.0,
                     y = 0.0,
                     width = 100,
                     height = 100,
                     angle = 0,
                     strokeColor = "#000000",
                     backgroundColor = "#868e96",
                     fillStyle = "solid",
                     strokeWidth = 2L,
                     strokeStyle = "solid",
                     roughness = 0L,
                     opacity = 100L,
                     groupIds = list(),
                     strokeSharpness = c("sharp",
                                         "round"),
                     isDeleted = FALSE,
                     boundElementIds = NA,
                     text = "text",
                     fontSize = 36L,
                     fontFamily = 1L,
                     textAlign = "left",
                     verticalAlign = "top",
                     baseline = 32L,
                     version = 1,
                     versionNonce = 12345) {
  type = 'text'
  
  fillStyle = match.arg(fillStyle)
  strokeStyle = match.arg(strokeStyle)
  strokeSharpness = match.arg(strokeSharpness)
  
  new_elem <- as.list(environment())
  
  # hashing the element to make a unique ID
  drop <- names(new_elem) %in% c('version', 'versionNonce')
  new_elem$id =  digest::digest(new_elem[!drop],
                                algo = "md5")
  
  # assign random seed
  new_elem$seed = abs(sample(.seeds, 1))
  
  new_elem
}

#' @title xkd_element
#' @param x x position of glyph in px
#' @param y y position of glyph in px
#' @param width glyph width in px
#' @param height  glyph height in px
#' @param angle in radians
#' @param strokeColor HTML colour code
#' @param backgroundColor HTML colour code
#' @param fillStyle "solid" or "hachure" or "cross-hatch"
#' @param strokeWidth 1 or 2 or 4
#' @param strokeStyle "solid" or "dashed" or "dotted"
#' @param roughness degree of wiggliness, 0 or 1 or 2 
#' @param opacity 0 to 100
#' @param groupIds list of strings indicating groupings
#' @param strokeSharpness "sharp" or "round"
#' @param isDeleted tag for collaboration
#' @param boundElementIds list of IDs used for connectors
#' @param version of glyph for collaboration
#' @param versionNonce of glyph for collaboration
#' @export
xkd_element <- function(type = 'rectangle',
                        x = 0.0,
                        y = 0.0,
                        width = 100,
                        height = 100,
                        angle = 0L,
                        strokeColor = "#000000",
                        backgroundColor = "#868e96",
                        fillStyle = c("solid",
                                      "hachure",
                                      "cross-hatch"),
                        strokeWidth = 2L,
                        strokeStyle = c("solid",
                                        "dashed",
                                        "dotted"),
                        roughness = 0L,
                        opacity = 100L,
                        groupIds = list(),
                        strokeSharpness = c("sharp","round"),
                        isDeleted = FALSE,
                        boundElementIds = NA,
                        version = 1,
                        versionNonce = 12345,
                        ...) {
  
  fillStyle = match.arg(fillStyle)
  strokeStyle = match.arg(strokeStyle)
  strokeSharpness = match.arg(strokeSharpness)
  
  new_elem <- as.list(environment())
  
  # hashing the element to make a unique ID
  drop <- names(new_elem) %in% c('version', 'versionNonce')
  new_elem$id =  digest::digest(new_elem[!drop],
                                algo = "md5")
  
  # assign random seed
  new_elem$seed = abs(sample(.seeds, 1))
  
  new_elem
}


# metadoc
if(FALSE){
  tpl <- "#' @param {p} of glyph"
  
  glue(p = names(formals(xkd_rectangle)), "#' @param {p} of glyph")
  
  all_names <- lapply(list(xkd_rectangle,
                           xkd_ellipse,
                           xkd_draw,
                           xkd_text), function(x)
                             names(formals(x)))
  # common params
  nms <- Reduce(intersect, all_names)
  glue(p = nms, "#' @param {p} of glyph")
  
  # specific ones
  
  glue(p = setdiff(all_names[[1]],nms), 
       "#' @param {p} of glyph")
  
  glue(p = setdiff(all_names[[2]],nms), 
       "#' @param {p} of glyph")
  
  glue(p = setdiff(all_names[[3]],nms), 
       "#' @param {p} of glyph")
  
  glue(p = setdiff(all_names[[4]],nms), 
       "#' @param {p} of glyph")
}