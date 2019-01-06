{ pkgs ? import <nixpkgs> {} }:
with pkgs; mkShell {
    name = "Rcpp";
    buildInputs = [ jdk ];
    shellHook = ''
        . ~/miniconda3/etc/profile.d/conda.sh

        env=Rcpp
        sh install_env.sh $env
        conda activate $env
    '';
}
