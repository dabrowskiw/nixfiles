{ pkgs, ... }:

{
  home.packages = [
    pkgs.lunarvim
  ];

  home.file.".config/lvim/config.lua".source = ./dotfiles/lvim/config.lua;
}
