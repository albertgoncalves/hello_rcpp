{ pkgs ? import <nixpkgs> {} }:
with pkgs; mkShell {
    name = "Rcpp";
    buildInputs = [
        jdk
        gawk
    ];
    shellHook = ''
        . ~/miniconda3/etc/profile.d/conda.sh

        cd src/
        env=Rcpp
        sh install_env.sh $env
        conda activate $env
        cd ../

        alias ls='ls --color=auto'
        alias ll='ls -al'

        lintr() {
            R -e "library(lintr); lint('$1')" \
                | awk '/> /{ found=1 } { if (found) print }'
        }

        export -f lintr
    '';
}
