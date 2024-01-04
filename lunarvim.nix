{ pkgs, ... }:

{
  home.packages = [
    pkgs.lunarvim
  ];

  home.file.".config/lvim" = {
    source = ./dotfiles/lvim;
    recursive = true;
  };
}
