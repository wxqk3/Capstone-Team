library(shiny)
library(dplyr)
library(lubridate)

# Load libraries and functions needed to create SQLite databases.
library(RSQLite)

saveSQLite <- function(data, name){
  path <- dplyr:::db_location(filename=paste0(name, ".sqlite"))
  if (!file.exists(path)) {
    message("Caching db at ", path)
    src <- src_sqlite(path, create = TRUE)
    copy_to(src, data, name, temporary = FALSE)
  } else {
    src <- src_sqlite(path)
  }
  return (src)
}

