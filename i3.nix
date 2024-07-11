{ pkgs, ... }:

{ 
  home.file.".config/i3" = {
    source = ./dotfiles/i3;
    recursive = true;
  };

  home.file.".config/i3/startPcloud.fish".source = ./dotfiles/startPcloud.fish;
  home.file.".config/i3/toggleTouchpad.fish".source = ./dotfiles/toggleTouchpad.fish;
  home.file.".config/i3/disableTouchpad.fish".source = ./dotfiles/toggleTouchpad.fish;
  home.file.".config/i3/runlutrisgame".source = pkgs.writeShellScript "runlutrisgame" ''
    gameid=`lutris --list-games | grep  "$1" | head -n 1 | cut -d "|" -f 1 | sed -e 's/ //g'`
    lutriscmd="env LUTRIS_SKIP_INIT=1 lutris lutris:rungameid/$gameid"
    $lutriscmd
  '';
}

