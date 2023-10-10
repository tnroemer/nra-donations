# borusyak et al. estimator
did_imputation_plot <- function(es){
    m1_data <- es[, 2:4]
    colnames(m1_data) <- c("report_year", "coef", "se")
    m1_data <- m1_data %>%
        filter(report_year %in% -5:4)
    m1_data <- m1_data %>%
        data.frame()
    m1_data[1, ] <- c(-1, 0, 0)
    m1_data <- m1_data %>%
        mutate(report_year = as.numeric(report_year)) %>%
        arrange(report_year)
    m1_data <- matrix(c(m1_data$coef, m1_data$se, rep(NA, 18)), ncol = 4)
    return(m1_data)
}

# chaisemartin estimator
did_multiplegt_plot <- function(es){
    tidy.did_multiplegt <- function(x, level = 0.95) {
        ests <- x[grepl("^placebo_|^effect|^dynamic_", names(x))]
        ret <- data.frame(
            term      = names(ests),
            estimate  = as.numeric(ests),
            std.error = as.numeric(x[grepl("^se_placebo|^se_effect|^se_dynamic", names(x))]),
            N         = as.numeric(x[grepl("^N_placebo|^N_effect|^N_dynamic", names(x))])
        ) |>
            # For CIs we'll assume standard normal distribution
            within({
                conf.low <- estimate - std.error * (qnorm(1 - (1 - level) / 2))
                conf.high <- estimate + std.error * (qnorm(1 - (1 - level) / 2))
            })
        return(ret)
    }
    m1_data <- tidy.did_multiplegt(es)
    m1_data <- m1_data[, 1:3]
    colnames(m1_data) <- c("report_year", "coef", "se")
    m1_data <- m1_data %>%
        mutate(
            report_year = str_replace(report_year, "placebo_", "-"),
            report_year = str_replace(report_year, "dynamic_", ""),
            report_year = str_replace(report_year, "effect", "0"),
            report_year = as.numeric(report_year)
        )
    m1_data <- matrix(c(m1_data$coef, m1_data$se, rep(NA, 18)), ncol = 4)
    return(m1_data)
}
