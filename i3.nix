{ ... }:

{ 
  home.file.".config/i3" = {
    source = ./dotfiles/i3;
    recursive = true;
  };

  home.file.".config/i3/startPcloud.fish".source = ./dotfiles/startPcloud.fish;
  home.file.".config/i3/toggleTouchpad.fish".source = ./dotfiles/toggleTouchpad.fish;
}

