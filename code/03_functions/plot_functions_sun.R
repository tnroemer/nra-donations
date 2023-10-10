# prepare result from Sun and Abraham for plotting with coefplot

sun_plot <- function(es){
    m1_data <- es$coeftable
    m1_data <- m1_data[, 1:2]
    colnames(m1_data) <- c("coef", "se")
    m1_data <- m1_data %>%
        data.frame() %>%
        rownames_to_column("report_year") %>%
        mutate(report_year = str_remove_all(report_year, "report_year::"))
    m1_data <- m1_data %>%
        mutate(report_year = as.numeric(report_year)) %>%
        filter(report_year %in% -5:4)
    m1_data[1, ] <- c(-1, 0, 0)
    m1_data <- m1_data %>%
        arrange(report_year)
    m1_data <- matrix(c(m1_data$coef, m1_data$se, rep(NA, 18)), ncol = 4)
    return(m1_data)
}
