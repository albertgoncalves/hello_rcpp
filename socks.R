#!/usr/bin/env Rscript

library(Rcpp)
sourceCpp("socks.cpp", cacheDir="lib")

# via http://www.sumsar.net/blog/2014/10/tiny-data-and-the-socks-of-karl-broman/

main = function() {
    set.seed(1)
    y = rep(1, 11)
    n = 1000000

    sims = n_sims(n, y)

    len = length(sims)
    if (len > 0) {
        hist(sims)
        print(len)
    }
}

if (sys.nframe() == 0) {
    main()
}
