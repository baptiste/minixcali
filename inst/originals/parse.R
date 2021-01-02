library(jsonlite)

el <- c('text', 'rectangle', 'ellipse', 'arrow', 'draw')

j <- jsonlite::read_json('inst/originals/text.json',
                         simplifyVector = FALSE)
j <- jsonlite::read_json('inst/originals/rectangle.json',
                         simplifyVector = FALSE)
j <- jsonlite::read_json('inst/originals/ellipse.json',
                         simplifyVector = FALSE)

j <- jsonlite::read_json('inst/originals/arrow.json',
                         simplifyVector = FALSE)

j <- jsonlite::read_json('inst/originals/draw.json',
                         simplifyVector = FALSE)
dput(j$elements[[1]])

text <- list(
  id = "ORfaHWjRfVKkgos0k84f7",
  type = "text",
  x = 0.0,
  y = 0.0,
  width = 85L,
  height = 46L,
  angle = 0L,
  strokeColor = "#000000",
  backgroundColor = "transparent",
  fillStyle = "solid",
  strokeWidth = 2L,
  strokeStyle = "solid",
  roughness = 0L,
  opacity = 100L,
  groupIds = list(),
  strokeSharpness = "sharp",
  seed = 2017538098L,
  version = 9L,
  versionNonce = 1979090738L,
  isDeleted = FALSE,
  boundElementIds = NULL,
  text = "text",
  fontSize = 36L,
  fontFamily = 1L,
  textAlign = "left",
  verticalAlign = "top",
  baseline = 32L
)

rectangle <-
  list(
    id = "YwR-psLDeVzv3aTQXpyHR",
    type = "rectangle",
    x = 126.219512195122,
    y = 240.780487804878,
    width = 445.121951219512,
    height = 275.609756097561,
    angle = 0L,
    strokeColor = "#000000",
    backgroundColor = "transparent",
    fillStyle = "solid",
    strokeWidth = 2L,
    strokeStyle = "solid",
    roughness = 0L,
    opacity = 100L,
    groupIds = list(),
    strokeSharpness = "sharp",
    seed = 2040801518L,
    version = 69L,
    versionNonce = 2017871986L,
    isDeleted = FALSE,
    boundElementIds = NULL
  )

ellipse <-
  list(
    id = "oaB5mI90MPLeXPKJPP9jP",
    type = "ellipse",
    x = 190.853658536586,
    y = 249.317073170732,
    width = 259.756097560976,
    height = 259.756097560976,
    angle = 0L,
    strokeColor = "#000000",
    backgroundColor = "transparent",
    fillStyle = "solid",
    strokeWidth = 2L,
    strokeStyle = "solid",
    roughness = 0L,
    opacity = 100L,
    groupIds = list(),
    strokeSharpness = "sharp",
    seed = 17328690L,
    version = 26L,
    versionNonce = 1293440238L,
    isDeleted = FALSE,
    boundElementIds = NULL
  )


arrow <-
  list(
    id = "kWmAPhxFyZW50VepwiMUe",
    type = "arrow",
    x = 228.658536585366,
    y = 326.146341463414,
    width = 164.634146341463,
    height = 0L,
    angle = 0L,
    strokeColor = "#000000",
    backgroundColor = "transparent",
    fillStyle = "solid",
    strokeWidth = 2L,
    strokeStyle = "solid",
    roughness = 0L,
    opacity = 100L,
    groupIds = list(),
    strokeSharpness = "sharp",
    seed = 804066546L,
    version = 47L,
    versionNonce = 501470514L,
    isDeleted = FALSE,
    boundElementIds = NULL,
    points = list(list(0L, 0L), list(164.634146341463, 0L)),
    lastCommittedPoint = NULL,
    startBinding = NULL,
    endBinding = NULL,
    startArrowhead = NULL,
    endArrowhead = "arrow"
  )

draw <-
  list(
    id = "Kb_WexEmXWXa7-WbfWlj4",
    type = "draw",
    x = 299.390243902439,
    y = 389.560975609756,
    width = 82.9268292682927,
    height = 86.5853658536585,
    angle = 0L,
    strokeColor = "#000000",
    backgroundColor = "transparent",
    fillStyle = "solid",
    strokeWidth = 2L,
    strokeStyle = "solid",
    roughness = 0L,
    opacity = 100L,
    groupIds = list(),
    strokeSharpness = "round",
    seed = 681080882L,
    version = 59L,
    versionNonce = 1755303538L,
    isDeleted = FALSE,
    boundElementIds = NULL,
    points = list(
      list(0L, 0L),
      list(0L,-3.65853658536582),
      list(6.09756097560978,-14.6341463414634),
      list(47.5609756097562,-58.5365853658536),
      list(74.390243902439,-82.9268292682927),
      list(82.9268292682927,-86.5853658536585)
    ),
    lastCommittedPoint = NULL,
    startBinding = NULL,
    endBinding = NULL,
    startArrowhead = NULL,
    endArrowhead = NULL
  )



.ids <- list(
  id = "oaB5mI90MPLeXPKJPP9jP",
  seed = 17328690L,
  version = 26L,
  versionNonce = 1293440238L
)

.text <- 
  list(
    type = "text",
    x = 0.0,
    y = 0.0,
    width = 100,
    height = 100,
    angle = 0,
    strokeColor = "#000000",
    backgroundColor = "transparent",
    fillStyle = "solid",
    strokeWidth = 2L,
    strokeStyle = "solid",
    roughness = 0L,
    opacity = 100L,
    groupIds = list(),
    strokeSharpness = "sharp",
    isDeleted = FALSE,
    boundElementIds = NULL,
    text = "text",
    fontSize = 36L,
    fontFamily = 1L,
    textAlign = "left",
    verticalAlign = "top",
    baseline = 32L
  )

.rectangle <-
  list(
    type = "rectangle",
    x = 0.0,
    y = 0.0,
    width = 100,
    height = 100,
    angle = 0L,
    strokeColor = "#000000",
    backgroundColor = "transparent",
    fillStyle = "solid",
    strokeWidth = 2L,
    strokeStyle = "solid",
    roughness = 0L,
    opacity = 100L,
    groupIds = list(),
    strokeSharpness = "sharp",
    isDeleted = FALSE,
    boundElementIds = NULL
  )

.ellipse <-
  list(
    type = "ellipse",
    x = 0.0,
    y = 0.0,
    width = 100,
    height = 100,
    angle = 0L,
    strokeColor = "#000000",
    backgroundColor = "transparent",
    fillStyle = "solid",
    strokeWidth = 2L,
    strokeStyle = "solid",
    roughness = 0L,
    opacity = 100L,
    groupIds = list(),
    strokeSharpness = "sharp",
    isDeleted = FALSE,
    boundElementIds = NULL
  )

.arrow <-
  list(
    type = "arrow",
    x = 0,
    y = 0,
    width = 100,
    height = 0L,
    angle = 0L,
    strokeColor = "#000000",
    backgroundColor = "transparent",
    fillStyle = "solid",
    strokeWidth = 2L,
    strokeStyle = "solid",
    roughness = 0L,
    opacity = 100L,
    groupIds = list(),
    strokeSharpness = "sharp",
    isDeleted = FALSE,
    boundElementIds = NULL,
    points = list(list(0L, 0L), 
                  list(100, 0L)),
    lastCommittedPoint = NULL,
    startBinding = NULL,
    endBinding = NULL,
    startArrowhead = NULL,
    endArrowhead = "arrow"
  )

.draw <-
  list(
    type = "draw",
    x = 0,
    y = 0,
    width = 100,
    height = 100,
    angle = 0L,
    strokeColor = "#000000",
    backgroundColor = "transparent",
    fillStyle = "solid",
    strokeWidth = 1L,
    strokeStyle = "solid",
    roughness = 0L,
    opacity = 100L,
    groupIds = list(),
    strokeSharpness = "round",
    isDeleted = FALSE,
    boundElementIds = NULL,
    points = list(list(0L, 0L), 
                  list(100, 0L)),
    lastCommittedPoint = NULL,
    startBinding = NULL,
    endBinding = NULL,
    startArrowhead = NULL,
    endArrowhead = NULL
  )

