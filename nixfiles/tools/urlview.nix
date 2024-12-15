{ pkgs, ... }:

{
  home.packages = [
    pkgs.urlview
  ];

  home.file.".urlview".source = ./dotfiles/.urlview;
}
