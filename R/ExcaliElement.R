
ExcaliElement <- R6::R6Class(
  "ExcaliElement", 
  
  public = list(
    
    update = function(...) {
      
      invisible(self)
    },
    
    append = function(..., position = NULL) {
      child_objects <- list(...)
      
      child_objects <- Filter(Negate(is.null), child_objects)
      
      if (is.null(position)) {
        self$children <- append(self$children, child_objects)
      } else {
        self$children <- append(self$children, child_objects, after = position - 1)
      }
      
      # update $child
      lapply(child_objects, self$update_child_list)
      
      invisible(self)
    },
    
    add = function(name, ...) {
      if (!is.character(name)) {
        stop("ExcaliElement$add(): 'name' must be a character string")
      }
      
      new_elem <- ExcaliElement$new(name, ...)
      
      self$append(new_elem)
      invisible(new_elem)
    },
    
    
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #' @description Remove child objects at the given indices
    #'
    #' @param indices indices of the children to remove
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    remove = function(indices) {
      self$children[indices] <- NULL
      invisible(self)
    }
    
    
    
    
    
  ) # End 'public'
  
  
  
)



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' @rdname ExcaliElement
#' @usage NULL
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Excali_elem <- function(name, ...) {
  ExcaliElement$new(name, ...)
}





