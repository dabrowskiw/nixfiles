{ pkgs, pkgs-unstable, config, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "wojtek";
  home.homeDirectory = "/home/wojtek";
  programs.man.generateCaches = false;
    
  gtk = {
    enable = true;
    font.name = "Victor Mono SemiBold 12";
    theme = {
      name = "yaru-dark";
      package = pkgs.yaru-theme;
    };
  };
  gtk.gtk4.theme = config.gtk.theme;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  imports = [
    ../tools/aerc.nix
    ../tools/espanso.nix
    ../tools/firefox.nix
    ../tools/fish.nix
    ../tools/git.nix
    ../tools/gpg.nix
    ../tools/i3.nix
    ../tools/khard.nix
    ../tools/msmtp.nix
    ../tools/nvim.nix
    ../tools/onedrive.nix
    ../tools/packages-unfree.nix
    ../tools/packages.nix
    ../tools/pass.nix
    ../tools/python.nix
    ../tools/unstablepkgs.nix
    ../tools/pimsync.nix
    ../tools/teams.nix
    ../tools/terminal-filechooser.nix
    ../tools/wezterm.nix
    ../tools/singularity.nix
  ];


  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/wojtek/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
