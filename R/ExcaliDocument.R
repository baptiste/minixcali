
if (FALSE) {
  
  library(miniexcali)
  
  a <- Excali_doc()
  a$add(list(id = "eGTFBfkR25EPddNpfGZij", 
             type = "rectangle", 
             x = -39L, 
             y = 45L, 
             width = 376L, 
             height = 232L, 
             angle = 0L, 
             strokeColor = "#000000", 
             backgroundColor = "#ced4da", 
             fillStyle = "hachure", 
             strokeWidth = 1L, 
             strokeStyle = "solid", 
             roughness = 1L, 
             opacity = 80L, 
             groupIds = list(list()), 
             strokeSharpness = "sharp", 
             seed = 862063609L, 
             version = 32L, 
             versionNonce = 784119031L, 
             isDeleted = FALSE, 
             boundElementIds = NA))
  
  a$add_rectangle()
  a$export('test.json')
  
}

ExcaliDoc <- R6::R6Class(
  "ExcaliDoc",
  
  public = list(type = NULL, 
                version = NULL, 
                source = NULL,
                appState = NULL,
                elements = list(),
                
                initialize = function() {
                  
                  self$type   <- "excalidraw"
                  self$version <- 2L
                  self$source  <- "https://excalidraw.com"
                  self$appState <- list(viewBackgroundColor = "#ffffff", 
                                        gridSize = NA)
                  
                  invisible(self)
                },
                
                add = function(...){
                  
                  self$elements <- c(self$elements, list(...))
                  invisible(self)
                  
                },
                
                #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                #' @description Add a rectangle to the scene
                #'
                #' @param ... glyph attributes
                #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                add_rectangle = function(...){
                  
                  new_elem <- g_rectangle(...)
                  
                  self$elements <- c(self$elements, list(new_elem))
                  invisible(self)
                  
                },
                
                export = function(file, ...){
                  
                  doc <- list(type = self$type, 
                              version = self$version, 
                              source = self$source, 
                              elements = self$elements,
                              appState = self$appState)
                  
                  jsonlite::write_json(doc, file, 
                                       flatten=TRUE, 
                                       auto_unbox=TRUE, 
                                       pretty = TRUE)
                  
                  
                }
                
  )
  
)

#' @param ... glyph attributes
#' @export
g_rectangle <- function(...){
  
  new_props <- list(...)
  new_props[is.na(new_props)] <- NULL # remove NAs
  
  new_elem <- modifyList(list(
    x = 0, 
    y = 0, 
    width = 400, 
    height = 300, 
    angle = 0, 
    strokeColor = "#495057", 
    backgroundColor = "#ced4da", 
    fillStyle = "hachure", 
    strokeWidth = 1, 
    strokeStyle = "solid", 
    roughness = 1L, 
    opacity = 100L,  
    strokeSharpness = "sharp", 
    isDeleted = FALSE, 
    boundElementIds = NA), 
    new_props)
  
  new_elem$type = "rectangle"
  new_elem$groupIds = list()
  # hashing the element to make a unique ID
  new_elem$id =  digest::digest(new_elem, algo="md5")
  new_elem$seed = abs(sample(.Random.seed[-1], 1))
  new_elem$version = 32L # no idea
  new_elem$versionNonce = 784119031L # no idea
  
  new_elem
}


#' @param ... glyph attributes
#' @export
g_element <- function(...){
  
  new_props <- list(...)
  new_props[is.na(new_props)] <- NULL # remove NAs
  if("points" %in% names(new_props)){
    # grab the matrix from the list wrapper
    new_props[['points']] <- new_props[['points']][[1]]
  }
  
  new_elem <- modifyList(list(
    type = 'rectangle', 
    x = 0, 
    y = 0, 
    width = 400, 
    height = 300, 
    angle = 0, 
    strokeColor = "#495057", 
    backgroundColor = "#ced4da", 
    fillStyle = "hachure", 
    strokeWidth = 1, 
    strokeStyle = "solid", 
    roughness = 1L, 
    opacity = 100L,  
    strokeSharpness = "sharp", 
    isDeleted = FALSE, 
    boundElementIds = NA), 
    new_props)
  
  new_elem$groupIds = list()
  # hashing the element to make a unique ID
  new_elem$id =  digest::digest(new_elem, algo="md5")
  new_elem$seed = abs(sample(.Random.seed[-1], 1))
  new_elem$version = 32L # no idea
  new_elem$versionNonce = 784119031L # no idea
  
  new_elem
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' @description Remove child objects at the given indices
#'
#' @export
#' @param indices indices of the children to remove
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Excali_doc <- function(...) {
  ExcaliDoc$new(...)
}
