#include <Rcpp.h>
using namespace Rcpp;

// via http://adv-r.had.co.nz/Rcpp.html

// [[Rcpp::export]]
void stl_sort(IntegerVector x) {
    std::sort(x.begin(), x.end());
}

// [[Rcpp::export]]
int count_changes(IntegerVector obs) {
    const int len_obs = obs.size();
    int n_unique = 1;

    for (int i = 0; i < (len_obs - 1); ++i) {
        if (obs[i] != obs[i + 1]) {
            ++n_unique;
        }
    }

    return n_unique;
}

// [[Rcpp::export]]
IntegerVector element_frequency(IntegerVector obs) {
    const int len_obs = obs.size() - 1;

    stl_sort(obs); // side-effects!
    const int n_unique = count_changes(obs);
    IntegerVector freq(n_unique);

    int count = 1;
    int pos = 0;
    int running_sum = 0;

    for (int i = 0; i < len_obs; ++i) {
        if (obs[i] == obs[i + 1]) {
            ++count;
        } else {
            freq[pos] = count;
            running_sum += count;
            ++pos;
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
        ++inc;
    }

    return a;
}

// [[Rcpp::export]]
IntegerVector pairs_array(int start, int n) {
    const int m = n * 2;
    IntegerVector a(m);
    int inc = start;
    int j = 0;

    for (int i = 0; i < n; ++i) {
        a[j] = inc;
        a[j + 1] = inc;
        j += 2;
        ++inc;
    }

    return a;
}

// [[Rcpp::export]]
IntegerVector concat_socks( int n_pairs, int n_singles, int m_pairs
                          , int total) {
    const IntegerVector singles = singles_array(1, n_singles);
    const IntegerVector pairs = pairs_array(n_singles + 1, n_pairs);
    IntegerVector socks(total);

    for (int i = 0; i < n_singles; ++i) {
        socks[i] = singles[i];
    }

    for (int i = 0; i < m_pairs; ++i) {
        socks[i + n_singles] = pairs[i];
    }

    return socks;
}

// [[Rcpp::export]]
bool compare_arrays(IntegerVector a, IntegerVector b, bool sort) {
    const int n_a = a.size();

    if (n_a != b.size()) {
        return false;
    }

    if (sort) {
        stl_sort(a); // more side-effects!
        stl_sort(b);
    }

    for (int i = 0; i < n_a; ++i) {
        if (a[i] != b[i]) {
            return false;
        }
    }

    return true;
}

// [[Rcpp::export]]
int sim(IntegerVector y) {
    const double theta_pairs = R::runif(10.0, 20.0);
    const int n_pairs = R::rpois(theta_pairs);

    if (n_pairs != 0) {
        const double theta_ratio = R::rbeta(1.2, 5.0);
        const int n_singles = R::rpois(n_pairs * theta_ratio);
        const int m_pairs = n_pairs * 2;
        const int total = m_pairs + n_singles;

        const IntegerVector socks =
            concat_socks(n_pairs, n_singles, m_pairs, total);
        const IntegerVector obs = sample(socks, sum(y), true);
        const IntegerVector freq = element_frequency(obs);

        if (compare_arrays(freq, y, false)) {
            return total;
        }
    }

    return 0;
}

// [[Rcpp::export]]
IntegerVector n_sims(int n, IntegerVector y) {
    IntegerVector sims(n);

    for (int i = 0; i < n; ++i) {
        sims[i] = sim(y);
    }

    return sims[sims > 0];
}
