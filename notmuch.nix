{ pkgs, ... }:

{
  home.packages = [
    pkgs.notmuch
  ];

  home.file.".notmuch-config".source = ./dotfiles/.notmuch-config;
}
