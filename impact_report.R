suppressPackageStartupMessages(library(rImpactStory))
# I created this collection via the website
# If your impactstory key is not stored in your .rprofile, add it below with key =
# metrics <- collection_metrics(collection_id = "d4npn7", key = "YOUR_KEY")
metrics <- collection_metrics(collection_id = "d4npn7")
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

# Function generates a barplot for each repo along with a legend.
impact_figure <- function(x) {
    df <- x[[1]][2:5]
    # Remove empty metrics and squash into a data.frame
    df2 <- ldply(df, function(x) {
        if (dim(x)[1] > 0)
            return(x)
    })
    # Pull out some metadata
    title <- x[[1]][[1]]$title
    year <- x[[1]][[1]]$year
    description <- x[[1]][[1]]$description
    tweets <- df2[which(df2$.id == "tweets"), ]$count
    stars <- df2[which(df2$.id == "stars"), ]$count
    stars_lower <- df2[which(df2$.id == "stars"), ]$CI95_lower
    forks <- df2[which(df2$.id == "forks"), ]$count
    forks_lower <- df2[which(df2$.id == "forks"), ]$CI95_lower
    # Format the legend
    legend <- sprintf("%s (%s) released in %s was discussed by the public %s times. This item has %d stars on GitHub. That's better than %s percent of items added to GitHub in the same year. The item has %d forks. This is better than %2d percent of GitHub repositories of the same age",
        title, description, year, tweets, stars, stars_lower, forks,
        forks_lower)
    # then the title
    ptitle <- sprintf("%s, %s", title, description)
    # add my ggplot theme
    theme_update(panel.background = element_blank(), panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), panel.border = element_blank(),
        axis.line = element_line(colour = "black"))
    # and make the plot
    plot1 <- ggplot(df2, aes(.id, count, fill = .id)) + geom_bar(stat = "identity",
        width = 0.5) + geom_bar(stat = "identity", color = "black", show_guide=FALSE) + scale_fill_brewer("Metrics", palette = 9) +
        ggtitle(ptitle) + xlab("Metrics") + ylab("Count")
    return(list(plot1, legend))
}

impact_figure(tabular_data[1])
# repeat the same for the others

