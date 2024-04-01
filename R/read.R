#' Read an Excalidraw file
#'
#' Read an Excalidraw file from a file or URL. If `simplifyVector = TRUE`, the
#' the diagram `elements` are returned as a data frame instead of a list. This
#' option makes the returned object is incompatible with the R6 methods in this
#' package.
#'
#' @param file A file path or URL for an Excalidraw file with a JSON or
#'   excalidraw file extension.
#' @param excalidoc Default `FALSE`. If `TRUE`, return a R6 `ExcaliDoc` class
#'   object.
#' @inheritParams jsonlite::read_json
#' @returns A named list or ExcaliDoc object
#' @export
#' @importFrom jsonlite read_json
xkd_read <- function(file,
                     excalidoc = FALSE,
                     simplifyVector = FALSE) {
  fileext <- tolower(tools::file_ext(file))

  if (!(fileext %in% c("json", "excalidraw"))) {
    rlang::abort(
      '`file` must have a "json" or "excalidraw" file extension.'
    )
  }
  
  doc <- jsonlite::read_json(
    path = file,
    simplifyVector = simplifyVector
  )
  
  doc[["elements"]] <- xkd_fmt_date(doc[["elements"]])
  
  if (!excalidoc) {
    return(doc)
  }
  
  doc_init <- Excali_doc()
  
  doc_init <- doc_init$replace(doc)
  
  doc_init
}
