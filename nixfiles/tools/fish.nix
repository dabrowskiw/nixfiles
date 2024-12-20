{ pkgs, ... }:

{
  home.packages = [
    pkgs.fishPlugins.tide
  ];


  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "tide";
        src = pkgs.fetchFromGitHub {
          owner = "IlanCosman";
          repo = "tide";
          rev = "44c521ab292f0eb659a9e2e1b6f83f5f0595fcbd";
          sha256 = "85iU1QzcZmZYGhK30/ZaKwJNLTsx+j3w6St8bFiQWxc=";
        };
      }
    ];

  };
  programs.fzf.enableFishIntegration = true;
  programs.fish.interactiveShellInit = 
    ''
set -U __fish_initialized 3400
set -U _tide_left_items vi_mode\x1epwd
set -U _tide_prompt_7083 \x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x5b38\x3b2\x3b52\x3b101\x3b164m\x1b\x5b48\x3b2\x3b52\x3b101\x3b164m\x20\x40PWD\x40\x20\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x5b38\x3b2\x3b52\x3b101\x3b164m\ue0b0\x1e\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x5b38\x3b2\x3b46\x3b52\x3b54m\ue0b2\x1b\x5b38\x3b2\x3b78\x3b154\x3b6m\x1b\x5b48\x3b2\x3b46\x3b52\x3b54m\x20\u2714\x20\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x5b38\x3b2\x3b46\x3b52\x3b54m
set -U _tide_prompt_84365 \x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x5b38\x3b2\x3b135\x3b175\x3b175m\x1b\x5b38\x3b2\x3b0\x3b0\x3b0m\x1b\x5b48\x3b2\x3b135\x3b175\x3b175m\x20I\x20\x1b\x5b38\x3b2\x3b135\x3b175\x3b175m\x1b\x5b48\x3b2\x3b52\x3b101\x3b164m\ue0b0\x1b\x5b48\x3b2\x3b52\x3b101\x3b164m\x20\x40PWD\x40\x20\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x5b38\x3b2\x3b52\x3b101\x3b164m\ue0b0\x1e\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x5b38\x3b2\x3b46\x3b52\x3b54m\ue0b2\x1b\x5b38\x3b2\x3b78\x3b154\x3b6m\x1b\x5b48\x3b2\x3b46\x3b52\x3b54m\x20\u2714\x20\x1b\x5b38\x3b2\x3b196\x3b160\x3b0m\x1b\x5b48\x3b2\x3b46\x3b52\x3b54m\ue0b2\x1b\x5b48\x3b2\x3b196\x3b160\x3b0m\x20\x1b\x5b37m\x1b\x5b38\x3b2\x3b0\x3b0\x3b0mmaster\x1b\x5b38\x3b2\x3b0\x3b0\x3b0m\x1b\x5b38\x3b2\x3b0\x3b0\x3b0m\x1b\x5b38\x3b2\x3b0\x3b0\x3b0m\x20\x2a1\x1b\x5b38\x3b2\x3b0\x3b0\x3b0m\x1b\x5b38\x3b2\x3b0\x3b0\x3b0m\x1b\x5b38\x3b2\x3b0\x3b0\x3b0m\x20\x215\x1b\x5b38\x3b2\x3b0\x3b0\x3b0m\x20\x1b\x28B\x1b\x5bm\x1b\x28B\x1b\x5bm\x1b\x5b38\x3b2\x3b196\x3b160\x3b0m
set -U _tide_prompt_84619 \x1b\x5bm\x0f\x1b\x5bm\x0f\x1b\x5b38\x3b2\x3b135\x3b175\x3b175m\x1b\x5b38\x3b2\x3b0\x3b0\x3b0m\x1b\x5b48\x3b2\x3b135\x3b175\x3b175m\x20I\x20\x1b\x5b38\x3b2\x3b135\x3b175\x3b175m\x1b\x5b48\x3b2\x3b52\x3b101\x3b164m\ue0b0\x1b\x5b48\x3b2\x3b52\x3b101\x3b164m\x20\x40PWD\x40\x20\x1b\x5bm\x0f\x1b\x5bm\x0f\x1b\x5b38\x3b2\x3b52\x3b101\x3b164m\ue0b0\x1e\x1b\x5bm\x0f\x1b\x5bm\x0f\x1b\x5b38\x3b2\x3b46\x3b52\x3b54m\ue0b2\x1b\x5b38\x3b2\x3b78\x3b154\x3b6m\x1b\x5b48\x3b2\x3b46\x3b52\x3b54m\x20\u2714\x20\x1b\x5b38\x3b2\x3b196\x3b160\x3b0m\x1b\x5b48\x3b2\x3b46\x3b52\x3b54m\ue0b2\x1b\x5b48\x3b2\x3b196\x3b160\x3b0m\x20\x1b\x5b37m\x1b\x5b38\x3b2\x3b0\x3b0\x3b0mmaster\x1b\x5b38\x3b2\x3b0\x3b0\x3b0m\x1b\x5b38\x3b2\x3b0\x3b0\x3b0m\x1b\x5b38\x3b2\x3b0\x3b0\x3b0m\x20\x2a1\x1b\x5b38\x3b2\x3b0\x3b0\x3b0m\x1b\x5b38\x3b2\x3b0\x3b0\x3b0m\x1b\x5b38\x3b2\x3b0\x3b0\x3b0m\x20\x215\x1b\x5b38\x3b2\x3b0\x3b0\x3b0m\x20\x1b\x5bm\x0f\x1b\x5bm\x0f\x1b\x5b38\x3b2\x3b196\x3b160\x3b0m
set -U _tide_prompt_85167 \x1b\x5bm\x0f\x1b\x5bm\x0f\x1b\x5b38\x3b2\x3b135\x3b175\x3b175m\x1b\x5b38\x3b2\x3b0\x3b0\x3b0m\x1b\x5b48\x3b2\x3b135\x3b175\x3b175m\x20I\x20\x1b\x5b38\x3b2\x3b135\x3b175\x3b175m\x1b\x5b48\x3b2\x3b52\x3b101\x3b164m\ue0b0\x1b\x5b48\x3b2\x3b52\x3b101\x3b164m\x20\x40PWD\x40\x20\x1b\x5bm\x0f\x1b\x5bm\x0f\x1b\x5b38\x3b2\x3b52\x3b101\x3b164m\ue0b0\x1e\x1b\x5bm\x0f\x1b\x5bm\x0f\x1b\x5b38\x3b2\x3b46\x3b52\x3b54m\ue0b2\x1b\x5b38\x3b2\x3b78\x3b154\x3b6m\x1b\x5b48\x3b2\x3b46\x3b52\x3b54m\x20\u2714\x20\x1b\x5b38\x3b2\x3b196\x3b160\x3b0m\x1b\x5b48\x3b2\x3b46\x3b52\x3b54m\ue0b2\x1b\x5b48\x3b2\x3b196\x3b160\x3b0m\x20\x1b\x5b37m\x1b\x5b38\x3b2\x3b0\x3b0\x3b0mmaster\x1b\x5b38\x3b2\x3b0\x3b0\x3b0m\x1b\x5b38\x3b2\x3b0\x3b0\x3b0m\x1b\x5b38\x3b2\x3b0\x3b0\x3b0m\x20\x2a1\x1b\x5b38\x3b2\x3b0\x3b0\x3b0m\x1b\x5b38\x3b2\x3b0\x3b0\x3b0m\x1b\x5b38\x3b2\x3b0\x3b0\x3b0m\x20\x215\x1b\x5b38\x3b2\x3b0\x3b0\x3b0m\x20\x1b\x5bm\x0f\x1b\x5bm\x0f\x1b\x5b38\x3b2\x3b196\x3b160\x3b0m
set -U _tide_right_items status\x1ecmd_duration\x1econtext\x1ejobs\x1epython\x1ejava\x1enix_shell\x1egit
set -U fish_color_autosuggestion brblack
set -U fish_color_cancel \x2dr
set -U fish_color_command blue
set -U fish_color_comment red
set -U fish_color_cwd green
set -U fish_color_cwd_root red
set -U fish_color_end green
set -U fish_color_error brred
set -U fish_color_escape brcyan
set -U fish_color_history_current \x2d\x2dbold
set -U fish_color_host normal
set -U fish_color_host_remote yellow
set -U fish_color_normal normal
set -U fish_color_operator brcyan
set -U fish_color_param cyan
set -U fish_color_quote yellow
set -U fish_color_redirection cyan\x1e\x2d\x2dbold
set -U fish_color_search_match bryellow\x1e\x2d\x2dbackground\x3dbrblack
set -U fish_color_selection white\x1e\x2d\x2dbold\x1e\x2d\x2dbackground\x3dbrblack
set -U fish_color_status red
set -U fish_color_user brgreen
set -U fish_color_valid_path \x2d\x2dunderline
set -U fish_key_bindings fish_vi_key_bindings
set -U fish_pager_color_completion normal
set -U fish_pager_color_description yellow\x1e\x2di
set -U fish_pager_color_prefix normal\x1e\x2d\x2dbold\x1e\x2d\x2dunderline
set -U fish_pager_color_progress brwhite\x1e\x2d\x2dbackground\x3dcyan
set -U fish_pager_color_selected_background \x2dr
set -U tide_aws_bg_color FF9900
set -U tide_aws_color 232F3E
set -U tide_aws_icon \uf270
set -U tide_character_color 5FD700
set -U tide_character_color_failure FF0000
set -U tide_character_icon \u276f
set -U tide_character_vi_icon_default \u276e
set -U tide_character_vi_icon_replace \u25b6
set -U tide_character_vi_icon_visual V
set -U tide_cmd_duration_bg_color C4A000
set -U tide_cmd_duration_color 000000
set -U tide_cmd_duration_decimals 0
set -U tide_cmd_duration_icon \x1d
set -U tide_cmd_duration_threshold 3000
set -U tide_context_always_display false
set -U tide_context_bg_color 444444
set -U tide_context_color_default D7AF87
set -U tide_context_color_root D7AF00
set -U tide_context_color_ssh D7AF87
set -U tide_context_hostname_parts 1
set -U tide_crystal_bg_color FFFFFF
set -U tide_crystal_color 000000
set -U tide_crystal_icon \ue62f
set -U tide_direnv_bg_color D7AF00
set -U tide_direnv_bg_color_denied FF0000
set -U tide_direnv_color 000000
set -U tide_direnv_color_denied 000000
set -U tide_direnv_icon \u25bc
set -U tide_distrobox_bg_color FF00FF
set -U tide_distrobox_color 000000
set -U tide_distrobox_icon \U000f01a7
set -U tide_docker_bg_color 2496ED
set -U tide_docker_color 000000
set -U tide_docker_default_contexts default\x1ecolima
set -U tide_docker_icon \uf308
set -U tide_elixir_bg_color 4E2A8E
set -U tide_elixir_color 000000
set -U tide_elixir_icon \ue62d
set -U tide_gcloud_bg_color 4285F4
set -U tide_gcloud_color 000000
set -U tide_gcloud_icon \U000f02ad
set -U tide_git_bg_color 4E9A06
set -U tide_git_bg_color_unstable C4A000
set -U tide_git_bg_color_urgent CC0000
set -U tide_git_color_branch 000000
set -U tide_git_color_conflicted 000000
set -U tide_git_color_dirty 000000
set -U tide_git_color_operation 000000
set -U tide_git_color_staged 000000
set -U tide_git_color_stash 000000
set -U tide_git_color_untracked 000000
set -U tide_git_color_upstream 000000
set -U tide_git_icon \x1d
set -U tide_git_truncation_length 24
set -U tide_git_truncation_strategy \x1d
set -U tide_go_bg_color 00ACD7
set -U tide_go_color 000000
set -U tide_go_icon \ue627
set -U tide_java_bg_color ED8B00
set -U tide_java_color 000000
set -U tide_java_icon \ue256
set -U tide_jobs_bg_color 444444
set -U tide_jobs_color 4E9A06
set -U tide_jobs_icon \uf013
set -U tide_jobs_number_threshold 1000
set -U tide_kubectl_bg_color 326CE5
set -U tide_kubectl_color 000000
set -U tide_kubectl_icon \U000f10fe
set -U tide_left_prompt_frame_enabled false
set -U tide_left_prompt_items vi_mode\x1epwd
set -U tide_left_prompt_prefix 
set -U tide_left_prompt_separator_diff_color \ue0b0
set -U tide_left_prompt_separator_same_color \ue0b1
set -U tide_left_prompt_suffix \ue0b0
set -U tide_nix_shell_bg_color 7EBAE4
set -U tide_nix_shell_color 000000
set -U tide_nix_shell_icon \uf313
set -U tide_node_bg_color 44883E
set -U tide_node_color 000000
set -U tide_node_icon \ue24f
set -U tide_os_bg_color 5277C3
set -U tide_os_color FFFFFF
set -U tide_os_icon \uf313
set -U tide_php_bg_color 617CBE
set -U tide_php_color 000000
set -U tide_php_icon \ue608
set -U tide_private_mode_bg_color F1F3F4
set -U tide_private_mode_color 000000
set -U tide_private_mode_icon \U000f05f9
set -U tide_prompt_add_newline_before true
set -U tide_prompt_color_frame_and_connection 6C6C6C
set -U tide_prompt_color_separator_same_color 949494
set -U tide_prompt_icon_connection \x20
set -U tide_prompt_min_cols 34
set -U tide_prompt_pad_items true
set -U tide_prompt_transient_enabled false
set -U tide_pulumi_bg_color F7BF2A
set -U tide_pulumi_color 000000
set -U tide_pulumi_icon \uf1b2
set -U tide_pwd_bg_color 3465A4
set -U tide_pwd_color_anchors E4E4E4
set -U tide_pwd_color_dirs E4E4E4
set -U tide_pwd_color_truncated_dirs BCBCBC
set -U tide_pwd_icon \x1d
set -U tide_pwd_icon_home \x1d
set -U tide_pwd_icon_unwritable \uf023
set -U tide_pwd_markers \x2ebzr\x1e\x2ecitc\x1e\x2egit\x1e\x2ehg\x1e\x2enode\x2dversion\x1e\x2epython\x2dversion\x1e\x2eruby\x2dversion\x1e\x2eshorten_folder_marker\x1e\x2esvn\x1e\x2eterraform\x1eCargo\x2etoml\x1ecomposer\x2ejson\x1eCVS\x1ego\x2emod\x1epackage\x2ejson\x1ebuild\x2ezig
set -U tide_python_bg_color 444444
set -U tide_python_color 00AFAF
set -U tide_python_icon \U000f0320
set -U tide_right_prompt_frame_enabled false
set -U tide_right_prompt_items status\x1ecmd_duration\x1econtext\x1ejobs\x1edirenv\x1enode\x1epython\x1erustc\x1ejava\x1ephp\x1epulumi\x1eruby\x1ego\x1egcloud\x1ekubectl\x1edistrobox\x1etoolbox\x1eterraform\x1eaws\x1enix_shell\x1ecrystal\x1eelixir\x1ezig\x1egit
set -U tide_right_prompt_prefix \ue0b2
set -U tide_right_prompt_separator_diff_color \ue0b2
set -U tide_right_prompt_separator_same_color \ue0b3
set -U tide_right_prompt_suffix 
set -U tide_ruby_bg_color B31209
set -U tide_ruby_color 000000
set -U tide_ruby_icon \ue23e
set -U tide_rustc_bg_color F74C00
set -U tide_rustc_color 000000
set -U tide_rustc_icon \ue7a8
set -U tide_shlvl_bg_color 808000
set -U tide_shlvl_color 000000
set -U tide_shlvl_icon \uf120
set -U tide_shlvl_threshold 1
set -U tide_status_bg_color 2E3436
set -U tide_status_bg_color_failure CC0000
set -U tide_status_color 4E9A06
set -U tide_status_color_failure FFFF00
set -U tide_status_icon \u2714
set -U tide_status_icon_failure \u2718
set -U tide_terraform_bg_color 800080
set -U tide_terraform_color 000000
set -U tide_terraform_icon \U000f1062
set -U tide_time_bg_color D3D7CF
set -U tide_time_color 000000
set -U tide_time_format 
set -U tide_toolbox_bg_color 613583
set -U tide_toolbox_color 000000
set -U tide_toolbox_icon \ue24f
set -U tide_vi_mode_bg_color_default 949494
set -U tide_vi_mode_bg_color_insert 87AFAF
set -U tide_vi_mode_bg_color_replace 87AF87
set -U tide_vi_mode_bg_color_visual FF8700
set -U tide_vi_mode_color_default 000000
set -U tide_vi_mode_color_insert 000000
set -U tide_vi_mode_color_replace 000000
set -U tide_vi_mode_color_visual 000000
set -U tide_vi_mode_icon_default D
set -U tide_vi_mode_icon_insert I
set -U tide_vi_mode_icon_replace R
set -U tide_vi_mode_icon_visual V
set -U tide_zig_bg_color F7A41D
set -U tide_zig_color 000000
set -U tide_zig_icon \ue6a9
if not set -q TMUX
  exec tmux
end
  '';

#  home.file.".config/fish" = {
#    source = ./dotfiles/fish;
#    recursive = true;
#  };
}
