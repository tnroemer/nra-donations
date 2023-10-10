# prepare result from Callaway and Sant'Anna for plotting with coefplot

aggte_plot <- function(es){
    m1_coefs <- es$att.egt
    m1_ses <- es$se.egt
    m1_ses[4] <- 0
    m1_period <- -4:4
    m1_data <- matrix(c(m1_coefs, m1_ses, rep(NA, 18)), ncol = 4)
    return(m1_data)
}
