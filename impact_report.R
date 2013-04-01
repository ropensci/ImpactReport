# First create your collection via the website. Provide your
# GitHub username.  Then copy your ImpactStory report ID and
# paste it below.
impact_report_id <- "d4npn7"
# Unfortunately RCurl and RJSONIO have startup messages that
# can clutter a document
suppressPackageStartupMessages(suppressWarnings(library(rImpactStory)))
suppressPackageStartupMessages(library(plyr))
# If your impactstory key is not stored in your .rprofile, add it below with key =
# metrics <- collection_metrics(collection_id = impact_report_id, key = 'YOUR_KEY')
metrics <- collection_metrics(collection_id = impact_report_id)
title <- metrics[[9]]
# From all the fields returned, I just need the metrics
data <- metrics[[5]]
tabular_data <- llply(data, function(x) {
    # stars
    stars_metrics <- data.frame(x$metrics$`github:stars`$values$github)
    stars_data <- data.frame(count = x$metrics$`github:stars`$values$raw,
        t(data.frame(stars_metrics)))
    rownames(stars_data) <- NULL
    # tweets
    tweet_metrics <- t(data.frame(x$metrics$`topsy:tweets`$values$github))
    tweet_data <- data.frame(count = x$metrics$`topsy:tweets`$values$raw,
        tweet_metrics)
    rownames(tweet_data) <- NULL
    # bookmarks
    bookmarks_metrics <- t(data.frame(x$metrics$`delicious:bookmarks`$values$github))
    bookmarks_data <- data.frame(count = x$metrics$`delicious:bookmarks`$values$raw,
        bookmarks_metrics)
    rownames(bookmarks_data) <- NULL
    # forks
    forks_metrics <- t(data.frame(x$metrics$`github:forks`$values$github))
    fork_data <- data.frame(count = x$metrics$`github:forks`$values$raw,
        forks_metrics)
    rownames(fork_data) <- NULL
    # and finally the metadata
    results <- data.frame(title = x$biblio[[6]], URL = x$aliases$url,
        description = x$biblio[[2]], year = x$biblio[[8]])
    return(list(results, stars = stars_data, tweets = tweet_data,
        bookmarks = bookmarks_data, forks = fork_data))
})
github_data <- function(foo) {
    data <- ldply(foo[2:length(foo)])
    names(data)[1] <- "metric"
    info <- ldply(foo[1])
    data$title <- info[1, ]$title
    data$url <- info[1, ]$url
    data$description <- info[1, ]$description
    data$year <- info[1, ]$year
    return(data)
}
simpleCap <- function(x) {
    foo <- paste(toupper(substring(x, 1, 1)), substring(x, 2, nchar(x)),
        sep = "", collapse = " ")
    return(foo)
}
