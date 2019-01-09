#!/usr/bin/env Rscript

library(Rcpp)
sourceCpp("socks.cpp", cacheDir="lib")

# via http://www.sumsar.net/blog/2014/10/tiny-data-and-the-socks-of-karl-broman/

main = function() {
    y = rep(1, 11)
    n = 1000000

    sims = n_sims(n, y)

    # if (length(sims) > 0)
    #     hist(sims)
}

if (sys.nframe() == 0) {
    main()
}
