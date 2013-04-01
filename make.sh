# Knits report
Rscript -e "library(knitr); knit('report.Rnw', quiet = TRUE)"
pdflatex report.tex
cp report.pdf ~/Dropbox/Public/report.pdf
