{ pkgs ? import <nixpkgs> {} }:
with pkgs; mkShell {
    name = "Rcpp";
    buildInputs = [ R
                    rPackages.Rcpp
                    glibcLocales
                  ];
    shellHook = ''
        alias open=xdg-open
    '';
}
