#' ExcaliDocument
#' 
#' @description
#' R6 Methods for ExcaliDocument object. Object structure is based on the
#' Excalidraw JSON Schema:
#' <https://docs.excalidraw.com/docs/codebase/json-schema>
#' 
#' @keywords internal
ExcaliDocument <- R6::R6Class(
  "ExcaliDocument",
  
  public = list(
    
    #' @field type (`character(1)`)\cr
    #' The type of the Excalidraw schema
    type = NULL,
    
    #' @field version (`integer(1)`)\cr
    #' The version of the Excalidraw schema
    version = NULL,
    
    #' @field source (`character(1)`)\cr
    #' The source URL of the Excalidraw application
    source = NULL,
    
    #' @field elements (`list()`)\cr
    #' A list of objects representing excalidraw elements on canvas	
    elements = list(),
    
    #' @field appState (`list()`)\cr
    #' Additional application state/configuration	
    appState = NULL,
    
    #' @field files (`list()`)\cr
    #' List of data for excalidraw image elements
    files = NULL,
    
    #' @description Initialize an ExcalidrawDoc object
    initialize = function() {
      self$type   <- "excalidraw"
      self$version <- 2L
      self$source  <- "https://baptiste.github.io/minixcali/"
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
    
    #' @description Replace all diagram components
    #'
    #' @param ... List of replacement components
    replace = function(...) {
      replacement <- c(...)
      self$elements <- replacement$elements %||% self$elements
      self$type   <- replacement$type %||% self$type
      self$version <- replacement$version %||% self$version
      self$source  <- replacement$source %||% self$source
      self$appState <- replacement$appState %||% self$appState
      self$files <- replacement$files %||% self$files
      invisible(self)
    },
    
    #' @description Save the document as json
    #' @param file Export file path
    export = function(file) {
      doc <- list(
        type = self$type,
        version = self$version,
        source = self$source,
        elements = xkd_fmt_epoch(self$elements),
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
