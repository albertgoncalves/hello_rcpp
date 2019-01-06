#!/usr/bin/env Rscript

library(Rcpp)
sourceCpp("socks.cpp")

# via http://www.sumsar.net/blog/2014/10/tiny-data-and-the-socks-of-karl-broman/

socks = function(n_pairs, n_singles) {
    singles = singles_array(1, n_singles)
    pairs = pairs_array(length(singles) + 1, n_pairs)
    return(c(singles, pairs))
}

sim = function(y) {
    theta_pairs = runif(1, 10, 20)
    theta_ratio = runif(1, 0, 0.25)

    n_pairs = rpois(1, theta_pairs)

    if (n_pairs != 0) {
        n_singles = rpois(1, n_pairs * theta_ratio)
        m = (n_pairs * 2) + n_singles

        collection = socks(n_pairs, n_singles)
        obs = sample(collection, 11, replace=TRUE)
        freq = element_frequency(obs)

        if (compare_arrays(freq, y))
            return(m)
    }

    return(0)
}

main = function() {
    y = rep(1, 11)
    n = 100000
    sims = replicate(n, sim(y))
    sims = sims[which(sims > 0)]
    n_sims = length(sims)

    if (n_sims > 0)
        hist(sims)
}

if (sys.nframe() == 0) {
    main()
}
