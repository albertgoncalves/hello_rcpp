#include <Rcpp.h>
using namespace Rcpp;

// via http://adv-r.had.co.nz/Rcpp.html

// [[Rcpp::export]]
NumericVector stl_sort(NumericVector x) {
    NumericVector y = clone(x);
    std::sort(y.begin(), y.end());
    return y;
}

// [[Rcpp::export]]
int count_changes(NumericVector obs) {
    int len_obs = obs.size();
    int n_unique = 1;

    for (int i = 0; i < (len_obs - 1); ++i) {
        if (obs[i] != obs [i + 1]) {
            n_unique++;
        }
    }

    return n_unique;
}

// [[Rcpp::export]]
IntegerVector element_frequency(NumericVector obs) {
    int len_obs = obs.size() - 1;

    obs = stl_sort(obs);
    int n_unique = count_changes(obs);

    int count = 1;
    int pos = 0;
    IntegerVector freq(n_unique);
    int running_sum = 0;

    for (int i = 0; i < len_obs; ++i) {
        if (obs[i] == obs[i + 1]) {
            count++;
        } else {
            freq[pos] = count;
            running_sum = running_sum + count;
            pos++;
            count = 1;
        }
    }

    freq[n_unique - 1] = len_obs - running_sum + 1;

    return freq;
}

// [[Rcpp::export]]
IntegerVector singles_array(int start, int n) {
    IntegerVector a(n);
    int inc = start;

    for (int i = 0; i < n; ++i) {
        a[i] = inc;
        inc++;
    }

    return a;
}

// [[Rcpp::export]]
IntegerVector pairs_array(int start, int n) {
    int m = n * 2;
    IntegerVector a(m);
    int inc = start;
    int j = 0;

    for (int i = 0; i < n; ++i) {
        a[j] = inc;
        a[j + 1] = inc;
        j = j + 2;
        inc++;
    }

    return a;
}

// [[Rcpp::export]]
bool compare_arrays(IntegerVector a, IntegerVector b) {
    int n_a = a.size();

    if (n_a != b.size()) {
        return false;
    }

    for (int i = 0; i < n_a; ++i) {
        if (a[i] != b[i]) {
            return false;
        }
    }

    return true;
}
