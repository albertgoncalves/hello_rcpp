#!/usr/bin/env Rscript

library(Rcpp)
sourceCpp("socks.cpp")

# via http://www.sumsar.net/blog/2014/10/tiny-data-and-the-socks-of-karl-broman/

main = function() {
    y = rep(1L, 11L)
    n = 1000000L

    sims = n_sims(n, y)
    sims = sims[which(sims > 0L)]
    n_sims = length(sims)

    if (n_sims > 0L)
        hist(sims)
}

if (sys.nframe() == 0) {
    main()
}
