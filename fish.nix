{ pkgs, ... }:

{
  home.packages = [
    pkgs.fish
  ];

  home.file.".config/fish" = {
    source = ./dotfiles/fish;
    recursive = true;
  };
}
