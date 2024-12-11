{ pkgs-unstable, ... }:

{
  home.packages = [
    pkgs-unstable.lunarvim
  ];

  home.file.".config/lvim/config.lua".source = ./dotfiles/lvim/config.lua;
}
