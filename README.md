# Hello, Rcpp!

Implemented a slightly modified version of [Tiny Data, Approximate Bayesian Computation and the Socks of Karl Broman](http://www.sumsar.net/blog/2014/10/tiny-data-and-the-socks-of-karl-broman/) in R; it was very slow. I explored [Rcpp](http://adv-r.had.co.nz/Rcpp.html) to see if I could make it faster.

**Rcpp** is fantastic; the script became much, *much* faster.

Needed things
---
 - [Nix](https://nixos.org/nix/)

Additional things if you are (for better or for worse) running macOS
---
 - [Conda](https://anaconda.org/)

---
```bash
$ sh shell.sh
```
To run the script:
```bash
[nix-shell:~/hello_rcpp]$ Rscript socks.R
[nix-shell:~/hello_rcpp]$ open Rplots.pdf
```
If that's not your style, this works too:
```bash
[nix-shell:~/hello_rcpp]$ R
```
```R
> source("socks.R")
> main()
```
