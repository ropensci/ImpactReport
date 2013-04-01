# First create your collection via the website. Provide your
# GitHub username.  Then copy your ImpactStory report ID and
# paste it below.
# --------------------------------------------------------
impact_report_id <- "d4npn7"
# --------------------------------------------------------
# Unfortunately RCurl and RJSONIO have startup messages that
# can clutter a document so we suppress those.
suppressPackageStartupMessages(suppressWarnings(library(rImpactStory)))
suppressPackageStartupMessages(library(plyr))
suppressPackageStartupMessages(library(ggplot2))
# If your impactstory key is not stored in your .rprofile, add it below with
# key = metrics <-collection_metrics(collection_id = impact_report_id, key ='YOUR_KEY')
metrics <- collection_metrics(collection_id = impact_report_id)
title <- metrics[[which(names(metrics) == "title")]]
# From all the fields returned, we just need the data on individual items
data <- metrics[[which(names(metrics) == "items")]]

# This part extracts metrics from individual repos, and returns them all in a list
tabular_data <- llply(data, function(x) {
    empty_frame <- data.frame(count = 0, CI95_lower = 0, CI95_upper = 0,
        estimate_lower = 0, estimate_upper = 0)
    bookmarks_data <- empty_frame
    stars_data <- empty_frame
    fork_data <- empty_frame
    tweet_data <- empty_frame
    # stars
    stars_pos <- which(names(x$metrics$`github:stars`$values) ==
        "github")
    if (length(stars_pos) > 0) {
        stars_metrics <- data.frame(x$metrics$`github:stars`$values$github)
        stars_data <- data.frame(count = x$metrics$`github:stars`$values$raw,
            t(data.frame(stars_metrics)))
        rownames(stars_data) <- NULL
    }
    # tweets
    tweets_pos <- which(names(x$metrics$`topsy:tweets`$values) ==
        "github")
    if (length(tweets_pos) > 0) {
        tweet_metrics <- t(data.frame(x$metrics$`topsy:tweets`$values$github))
        tweet_data <- data.frame(count = x$metrics$`topsy:tweets`$values$raw,
            tweet_metrics)
        rownames(tweet_data) <- NULL
    }
    # bookmarks
    bookmarks_pos <- which(names(x$metrics$`delicious:bookmarks`$values) ==
        "github")
    if (length(bookmarks_pos) > 0) {
        bookmarks_metrics <- t(data.frame(x$metrics$`delicious:bookmarks`$values$github))
        bookmarks_data <- data.frame(count = x$metrics$`delicious:bookmarks`$values$raw,
            bookmarks_metrics)
        rownames(bookmarks_data) <- NULL
    }
    # forks
    forks_pos <- which(names(x$metrics$`github:forks`$values) ==
        "github")
    if (length(forks_pos) > 0) {
        forks_metrics <- t(data.frame(x$metrics$`github:forks`$values$github))
        fork_data <- data.frame(count = x$metrics$`github:forks`$values$raw,
            forks_metrics)
        rownames(fork_data) <- NULL
    }
    # and finally the metadata
    title <- x$biblio[[which(names(x$biblio) == "title")]]
    # Description and year fields can be empty. This catches missing ones.
    description <- ifelse(length(which(names(x$biblio) == "description")) >
        0, x$biblio[[which(names(x$biblio) == "description")]], "NA")
    year <- ifelse(length(which(names(x$biblio) == "year")) > 0,
        x$biblio[[which(names(x$biblio) == "year")]], "NA")
    results <- data.frame(title = title, URL = x$aliases$url, description = description,
        year = year)
    return(list(results, Stars = stars_data, Tweets = tweet_data,
        Bookmarks = bookmarks_data, Forks = fork_data))
})

# Squashes individual list items from above into a easily plottable data.frame
github_data <- function(input_data) {
    data <- ldply(input_data[2:length(input_data)])
    names(data)[1] <- "metric"
    info <- ldply(input_data[1])
    data$title <- info[1, ]$title
    data$url <- info[1, ]$url
    data$description <- info[1, ]$description
    data$year <- info[1, ]$year
    return(data)
}
