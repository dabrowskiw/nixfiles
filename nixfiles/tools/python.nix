{ pkgs, mypythonPackages, ... }:

{
 home.packages = [
  (pkgs.python3.withPackages (ps: with ps; [
    click
    debugpy
    flake8
    inquirerpy
    lz4
    psutil
    pytest
    pypdf2
    pypng
    reportlab
    requests
    setuptools
    transformers
    ollama
    jsonschema
    jinja2
    trafilatura
    nltk
    torch
    tqdm
    unidecode
    jedi-language-server # for vim-jedi-lsp
    debugpy # for vimspector
    pkgs.nltk-data.punkt
    pkgs.nltk-data.punkt-tab
#    (callPackage ./piecash.nix { inherit mypythonPackages; })
  ]))
 ];
  home.file."nltk_data".source = pkgs.nltk-data.punkt-tab;
}
