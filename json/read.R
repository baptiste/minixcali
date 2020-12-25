library(jsonlite)

j <- jsonlite::read_json('json/kevin.json', simplifyVector = FALSE)

.kevin <- lapply(j$elements, function(e) 
  list(x = e$x, y = e$y, 
       width = e$width, height = e$height,
       backgroundColor = e$backgroundColor,
       strokeColor = e$strokeColor,
       points = matrix(as.numeric(do.call(rbind, e$points)), 
         ncol=2, byrow = FALSE)))

dput(.kevin)

j <- jsonlite::read_json('json/roberto.json', simplifyVector = FALSE)

.roberto <- lapply(j$elements, function(e) 
  list(x = e$x, y = e$y, 
       width = e$width, height = e$height,
       backgroundColor = e$backgroundColor,
       strokeColor = e$strokeColor,
       points = matrix(as.numeric(do.call(rbind, e$points)), 
                       ncol=2, byrow = FALSE)))

dput(.roberto)

# saveRDS(list(kevin, roberto) , file='pdl.Rds')
