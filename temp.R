ggplot(df, aes(title, count, fill = metric)) + geom_bar(stat = "identity",
    aes(color = outline_color), show_guide = FALSE) + geom_bar(stat = "identity") +
    facet_wrap(~metric, nrow = 1) + coord_flip() + scale_fill_manual("Metrics",
    labels = c("Bookmarks", "Forks (citations)", "Stars (recommendation)",
        "Tweets (discussions)"), values = c("#D8CE6E", "#E4B0CB",
        "#90D4DF", "#8BE0A4")) + scale_color_manual(values = c("red",
    "white")) + xlab("") + ylab("Raw Counts")
ggplot(df, aes(title, count, fill = metric)) + geom_bar(stat = "identity",
    aes(color = outline_color), show_guide = FALSE) + geom_bar(stat = "identity") +
    facet_wrap(~metric, nrow = 1) + coord_flip() + scale_fill_manual("Metrics",
    labels = c("Bookmarks", "Forks (citations)", "Stars (recommendation)",
        "Tweets (discussions)"), values = c("#C152AA", "#65903E",
        "#C6583E", "#6A78B9")) + scale_color_manual(values = c("#fc7b7a",
    "white")) + xlab("") + ylab("Raw Counts")
ggplot(df, aes(title, count, fill = metric)) + geom_bar(stat = "identity",
    aes(color = outline_color), show_guide = FALSE) + geom_bar(stat = "identity",
    fill = "#1bb7d5") + facet_wrap(~metric, nrow = 1) + coord_flip() +
    scale_fill_manual("Metrics", labels = c("Bookmarks", "Forks (citations)",
        "Stars (recommendation)", "Tweets (discussions)"), values = c("#6F9544",
        "#B05BB3", "#BC5A45", "#667EA0")) + scale_color_manual(values = c("red",
    "white")) + xlab("") + ylab("Raw Counts")


ggplot(df, aes(title, count, fill = metric)) + geom_bar(stat = "identity",
    aes(fill = outline_color), show_guide = FALSE, color = "#5d5d5d") +
    facet_wrap(~metric, nrow = 1) + coord_flip() + scale_fill_manual(values = c("#ee701e",
    "#528dc6")) + xlab("") + ylab("Raw Counts")

ggplot(df2, aes(title, count, fill = metric)) + geom_bar(stat = "identity",
    aes(fill = outline_color), show_guide = FALSE, color = "#5d5d5d") +
    facet_wrap(~metric, nrow = 3, ncol =1) + scale_fill_manual(values = c("#ee701e",
    "#528dc6")) + xlab("") + ylab("Raw Counts")
