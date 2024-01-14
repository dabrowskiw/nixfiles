{ pkgs, ... }:

{
  home.packages = [
    pkgs.espanso
  ];

  home.file.".config/espanso" = {
    source = ./dotfiles/espanso;
    recursive = true;
  };
}
