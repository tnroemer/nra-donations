# define function to estimate time-averaged ATTs
estimate_att <- function(df, leave_out) {
    df_ <- df %>%
        filter(state_fips != leave_out)
    m1_ <- att_gt(
        data = df_,
        yname = "donations",
        gname = "first_treatment",
        tname = "report_year",
        idname = "id",
        base_period = "universal",
        pl = T,
        cores = 4
    )
    m1.es_ <- aggte(m1_,
                    type = "dynamic", na.rm = T, clustervars = "id",
                    balance_e = 4, min_e = -4
    )
    m1.df_ <- data.frame(m1.es_$overall.att, m1.es_$overall.se, NA, NA, state_code = as.character(i))
    return(m1.df_)
}