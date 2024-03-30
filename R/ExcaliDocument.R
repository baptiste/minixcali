#' ExcaliDocument
#' 
#' @description
#' R6 Methods for ExcaliDocument object
#' 
#' @keywords internal
ExcaliDocument <- R6::R6Class(
  "ExcaliDocument",
  
  public = list(
    
    #' @field type (`character(1)`)\cr
    #' Object type
    type = NULL,
    
    #' @field version (`integer(1)`)\cr
    #' ExcaliDraw version number
    version = NULL,
    
    #' @field source (`integer(1)`)\cr
    #' ExcaliDraw source
    source = NULL,
    
    #' @field appState (`list()`)\cr
    #' ExcaliDraw app state
    appState = NULL,
    
    #' @field files (`list()`)\cr
    #' ExcaliDraw files
    files = NULL,
    
    #' @field elements (`list()`)\cr
    #' ExcaliDraw elements
    elements = list(),
    
    #' @description Initialize an ExcalidrawDoc object
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
    #' @param file Export file path
    export = function(file) {
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
        path = file,
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
#' @returns An `ExcaliDocument` class object.
#' @export
Excali_doc <- function() {
  ExcaliDocument$new()
}
