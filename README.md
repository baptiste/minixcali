
<!-- README.md is generated from README.Rmd. Please edit that file -->

![preview](man/figures/overview.png)

<https://excalidraw.com/#json=5711173496340480,eQSvgvxy8AjKeGWJz1CfVQ>

## Usage

``` r
library(minixcali)

d <- Excali_doc()
shape <- xkd_rectangle(width = 300, height=200,
                       fillStyle = 'hachure', roughness = 2)
d$add(shape)
d$export(file='output.json')
```

![preview](man/figures/rectangle.png)
