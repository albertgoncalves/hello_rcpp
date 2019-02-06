{ pkgs ? import <nixpkgs> {} }:
with pkgs; mkShell {
    name = "Rcpp";
    buildInputs = [ R
                    rPackages.Rcpp
                    rPackages.lintr
                    glibcLocales
                    gawk
                  ];
    shellHook = ''
        alias open="xdg-open"

        lintr() {
            R -e "library(lintr); lint('$1')" \
                | awk '/> /{ found=1 } { if (found) print }'
        }

        export -f lintr
    '';
}
