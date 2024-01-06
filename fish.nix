{ pkgs, ... }:

{
  home.packages = [
    pkgs.fish
    pkgs.oh-my-fish
  ];

  home.file.".config/fish" = {
    source = ./dotfiles/fish;
    recursive = true;
  };
}
