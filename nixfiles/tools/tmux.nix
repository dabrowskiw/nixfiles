{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    secureSocket = true;
    plugins = with pkgs.tmuxPlugins; [
      onedark-theme
      tmux-fzf
      {
        plugin = tmux-thumbs;
        extraConfig = ''
          set -g @thumbs-command 'echo -n {} | xsel -b' 
          set -g @thumbs-unique enabled
          set -g @thumbs-key f
          set -g @thumbs-regexp-1 '([a-zA-Z0-9-\.]+@[a-zA-Z0-9-\.]+\.[a-zA-Z0-9-]{2,4})' 
        '';
      }
    ];
  };
}
