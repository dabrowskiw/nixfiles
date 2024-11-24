{ pkgs, config, ... }:
 
{
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = false;
    enableZshIntegration = false;
    settings = {
      scrollback_editor = "lvim";
    };
  };
}

