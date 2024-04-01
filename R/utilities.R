#' Convert epoch date/time to POSIXct
#' @noRd
from_epoch_date <- function(x) {
  as.POSIXct(x / 1000, tz = "UTC", origin = "1970-01-01")  
}

#' Convert a Date or POSIXt vector to epoch time
#' @noRd
to_epoch_date <- function(x, tz = "UTC") {
  stopifnot(
    inherits(x, c("Date", "POSIXt"))
  )
  
  as.numeric(as.POSIXlt(x, tz = tz)) * 1000
}

#' @noRd
xkd_fmt_date <- function(x) {
  if (!is.data.frame(x)) {
    x <- lapply(
      x,
      \(x) {
        if (!is.null(x[["updated"]])) {
          x[["updated"]] <- from_epoch_date(x[["updated"]])
        }
        
        x
      }
    )
  } else if (!is.null(x[["updated"]])) {
    x[["updated"]] <- from_epoch_date(x[["updated"]])
  }
  
  x
}

#' @noRd
xkd_fmt_epoch <- function(x) {
  if (!is.data.frame(x)) {
    x <- lapply(
      x,
      \(x) {
        if (!is.null(x[["updated"]])) {
          x[["updated"]] <- to_epoch_date(x[["updated"]])
        }
        
        x
      }
    )
  } else if (!is.null(x[["updated"]])) {
    x[["updated"]] <- to_epoch_date(x[["updated"]])
  }
}