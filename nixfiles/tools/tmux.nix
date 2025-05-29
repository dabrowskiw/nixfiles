{ pkgs, ... }:

let 
  formatmail = pkgs.writeTextFile {
    name = "khal_fzf";
    destination = "/bin/khal_fzf";
    executable = true;
    text = (builtins.readFile ../../scripts/khal_fzf);
  };
  tmux-menus = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "menus";
    version = "2.2.6";
    src = pkgs.fetchFromGitHub {
      owner = "jaclu";
      repo = "tmux-menus";
      rev = "b366a6d8af893222a5825ee504b9207f9e75cd4e";
      sha256 = "sha256-ASkglAChY2uJi4G/DwsYxLBKZE6GJvUQJUzhl48JMms=";
    };
#    postInstall = ''
#      chmod u+x $target/scripts/*.sh
#      chmod u+x $target/scripts/utils/*.sh
#      patchShebangs $target/scripts/*.sh
#      patchShebangs $target/scripts/utils/*.sh
#      sed -i -e 's|d_cache="\$D_TM_BASE_PATH"/cache|d_cache=/tmp/tmux-menus/cache|g' $target/scripts/helpers_minimal.sh
#      sed -i -e 's|d_custom_items="\$D_TM_BASE_PATH"/custom_items|d_custom_items=/tmp/tmux-menus/custom_items|g' $target/scripts/utils/helpers_full.sh
#    '';
  };
in
{
  home.packages = with pkgs; [
    formatmail
  ];

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    secureSocket = true;
    escapeTime = 0;
    extraConfig = ''
      bind m run-shell "khal_fzf; tmux set-buffer \"$(xsel -o --clipboard)\"; tmux paste-buffer;"
    '';
    plugins = with pkgs.tmuxPlugins; [
      onedark-theme
      tmux-fzf
#      {
#        plugin = tmux-menus;
#        extraConfig = ''
#        set -g @menus_use_cache 'No'
#        set -g @menus_trigger 'M'
#        set -g @menus_log_file '/tmp/tmux-menus.log'
#        '';
#      }
      yank
      copycat

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
