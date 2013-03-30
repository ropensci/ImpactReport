Rscript -e "library(knitr); knit('Impact_Report.Rmd', quiet =T)"
pandoc -H margins.sty Impact_report.md -o Impact_Report.pdf
open Impact_Report.pdf
