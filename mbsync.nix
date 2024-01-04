{ ... }:

{
  programs.mbsync = {
    enable = true;
  };

  home.file.".mbsyncrc".source = ./dotfiles/.mbsyncrc;

  services.mbsync = {
    enable = true;
    frequency = "15 minutes";
  };
}
