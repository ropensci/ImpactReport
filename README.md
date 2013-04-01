
# Generating static ImpactStory reports

ImpactStory can capture all of the discussion and influence of the code you deposit on GitHub. They have a great website where you can see all the metrics. But have you wanted to embed this information in a compact way on your CV or promotion/tenure report? Try this template! Simply edit the `.Rnw` file, and add in your collection ID. Otherwise use functions `github_report` and `github_plot` to generate figures and embed it other ways (see below). 

**Note:** If you've never used rImpactStory before, you'll need an API key. Get one by emailing [team@impactstory.org](mailto:team@impactstory.org)

1. Visit [ImpactStory.org](http://impactstory.org) and create a report by adding your GitHub username or GitHub organization's username. 
2. Copy the report ID at the end of the URL
3. Update to the latest version of [`rImpactStory`](https://github.com/ropensci/rImpactStory) (0.07)

```r
library(devtools)
install_github("rImpactStory", "ropensci")
```
## To generate a PDF report
Edit [`report.Rnw`](https://github.com/ropensci/ImpactReport/blob/master/report.Rnw) and add your impact ID.

knit the document:

```r
knitr::knit('report.Rnw')
system('pdflatex report.tex')
```

[resulting pdf](https://github.com/ropensci/ImpactReport/blob/master/report.pdf?raw=true).


## To generate a visualization in R

```r
library(rImpactStory)
df <- github_report("d4npn7")
# To visualize this, then use
github_plot(df)
```

You can save or embed this `ggplot2` object any way you like.

# The Report
![A sample ImpactStory report](impactreport.png)


Here's an impact report for some of the more complete rOpenSci packages. Orange bars indicate significant activity for a given metric. Bars are only significant when a metric is above the 75th percentile and exceeds a minimum frequency. Orange bars indicate that the repository was **highly discussed** (for tweets), **highly cited** (for forks), and/or **highly recommended** (for stars). It's easy to see that not many are being bookmarked on Delicious (not surprising). It's also cool to see packages that have wider appeal (like GBIF, figshare, and Mendeley) are showing up consistently across different metrics.

## Contributions
Please feel free to fork and submit other templates. Please file bugs [here](https://github.com/ropensci/ImpactReport/issues/new).

## Todo
Make other general templates that can handle full impact reports with other products. One could easily generate an up to date report and append it to a cv.

## Licence
CC0
