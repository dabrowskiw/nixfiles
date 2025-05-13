{ pkgs, ... }:

let 
  formatmail = pkgs.writeTextFile {
    name = "khal_fzf";
    destination = "/bin/khal_fzf";
    executable = true;
    text = (builtins.readFile ../../scripts/khal_fzf);
  };
in
{
  home.packages = [
    formatmail
  ];

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    secureSocket = true;
    escapeTime = 0;
    extraConfig = ''
      bind f run-shell "khal_fzf; tmux set-buffer \"$(xsel -o --clipboard)\"; tmux paste-buffer;"
    '';
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
