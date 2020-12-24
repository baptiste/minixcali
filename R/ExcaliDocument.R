
if (FALSE) {
  
library(R6)
  
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
             fillStyle = "solid", 
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

Excali_doc <- function(...) {
  ExcaliDoc$new(...)
}
