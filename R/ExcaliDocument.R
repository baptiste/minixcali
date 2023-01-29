

ExcaliDocument <- R6::R6Class(
  "ExcaliDocument",
  
  public = list(
    type = NULL,
    version = NULL,
    source = NULL,
    appState = NULL,
    files = NULL,
    elements = list(),
    
    initialize = function() {
      self$type   <- "excalidraw"
      self$version <- 2L
      self$source  <- "minixcali"
      self$appState <-
        list(viewBackgroundColor = "#ffffff",
             gridSize = NA)
      self$files <- list()
      invisible(self)
    },
    
    #' @description Add a glyph to the scene
    #'
    #' @param ... glyph attributes
    add = function(...) {
      self$elements <- c(self$elements, list(...))
      invisible(self)
      
    },
    
    #' @description Save the document as json
    export = function(file, ...) {
      doc <- list(
        type = self$type,
        version = self$version,
        source = self$source,
        elements = self$elements,
        appState = self$appState,
        files = self$files
      )
      
      jsonlite::write_json(
        doc,
        file,
        flatten = TRUE,
        auto_unbox = TRUE,
        pretty = TRUE
      )
      
    } # /export
    
  ) # /public
  
)

#' @title Excali_doc
#' @description Create a new ExcaliDocument
#'
#' @export
Excali_doc <- function() {
  ExcaliDocument$new()
}
