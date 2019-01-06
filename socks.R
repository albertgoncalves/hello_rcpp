#!/usr/bin/env Rscript

library(Rcpp)
sourceCpp("socks.cpp")

# via http://www.sumsar.net/blog/2014/10/tiny-data-and-the-socks-of-karl-broman/

socks = function(n_pairs, n_singles) {
    singles = singles_array(1L, n_singles)
    pairs = pairs_array(length(singles) + 1L, n_pairs)
    return(c(singles, pairs))
}

sim = function(y) {
    theta_pairs = runif(1L, 10.0, 20.0)
    theta_ratio = runif(1L, 0.0, 0.25)

    n_pairs = rpois(1L, theta_pairs)

    if (n_pairs != 0L) {
        n_singles = rpois(1L, n_pairs * theta_ratio)
        m = (n_pairs * 2L) + n_singles

        collection = socks(n_pairs, n_singles)
        obs = collection[.Internal(sample( m
                                         , size=11L
                                         , replace=TRUE
                                         , prob=NULL
                                         ))]
        freq = element_frequency(obs)

        if (compare_arrays(freq, y))
            return(m)
    }

    return(0L)
}

main = function() {
    y = rep(1, 11)
    n = 100000L

    sims = rep(0L, n)
    for (i in 1L:n)
        sims[i] = sim(y)

    sims = sims[which(sims > 0L)]
    n_sims = length(sims)

    if (n_sims > 0)
        hist(sims)
}

if (sys.nframe() == 0) {
    main()
}
