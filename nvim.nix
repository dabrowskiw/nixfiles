{ pkgs, ... }: 

{

  home.packages = [
    pkgs.bat
    pkgs.ripgrep
  ];

  programs.yazi = {
    enable = true;
    plugins = {
      fg = pkgs.yaziPlugins.fg;
    };
    keymap = {
      manager.keymap = [
      	{ on = [ "f" "f" ];	run = "plugin fg --args='fzf'"; desc = "find file by filename"; }
      	{ on = [ "f" "g" ];	run = "plugin fg"; desc = "find file by content (fuzzy match)"; }
      	{ on = [ "f" "G" ];	run = "plugin fg --args='rg'"; desc = "find file by content (exact match)"; }

        { on = [ "<Left>" ]; run = "leave"; desc = "Go back to the parent directory"; }
        { on = [ "<Down>" ]; run = "arrow 1"; desc = "Move cursor down"; }
        { on = [ "<Up>" ]; run = "arrow -1"; desc = "Move cursor up"; }
        { on = [ "<Right>" ]; run = "enter"; desc = "Enter the child directory"; }


        # tabs

        { on = [ "t" ]; run = "tab_create --current"; desc = "Create a new tab using the current path"; }
        { on = [ "<C-q>" ]; run = "close"; desc = "Close the current tab, or quit if it is last tab"; }
        { on = [ "1" ]; run = "tab_switch 0"; desc = "Switch to the first tab"; }
        { on = [ "2" ]; run = "tab_switch 1"; desc = "Switch to the second tab"; }
        { on = [ "3" ]; run = "tab_switch 2"; desc = "Switch to the third tab"; }
        { on = [ "4" ]; run = "tab_switch 3"; desc = "Switch to the fourth tab"; }
        { on = [ "5" ]; run = "tab_switch 4"; desc = "Switch to the fifth tab"; }
        { on = [ "6" ]; run = "tab_switch 5"; desc = "Switch to the sixth tab"; }
        { on = [ "7" ]; run = "tab_switch 6"; desc = "Switch to the seventh tab"; }
        { on = [ "8" ]; run = "tab_switch 7"; desc = "Switch to the eighth tab"; }
        { on = [ "9" ]; run = "tab_switch 8"; desc = "Switch to the ninth tab"; }
        { on = [ "0" ]; run = "tab_switch 9"; desc = "Switch to the tenth tab"; }


        # goto

        { on = [ "g" "h" ]; run = "cd ~"; desc = "Go to home"; }


        # selection

        { on = [ "<Space>" ]; run = [ "select --state=none" "arrow 1" ]; desc = "Toggle the current selection state"; }
        { on = [ "<C-a>" ]; run = "select_all --state=true"; desc = "Select all files"; }
        { on = [ "<C-r>" ]; run = "select_all --state=none"; desc = "Inverse selection of all files"; }
        { on = [ "m" ]; run = "visual_mode"; desc = "Enter visual mode (selection mode)"; }
        { on = [ "M" ]; run = "visual_mode --unset"; desc = "Enter visual mode (unset mode)"; }


        # basic file operations

        { on = [ "<Enter>" ]; run = "open"; desc = "Open the selected files"; }
        { on = [ "<C-Enter>" ]; run = "open --interactive"; desc = "Open the selected files interactively"; }
        { on = [ "y" ]; run = "yank"; desc = "Copy the selected files"; }
        { on = [ "Y" ]; run = "unyank"; desc = "Cancel the yank status of files"; }
        { on = [ "x" ]; run = "yank --cut"; desc = "Cut the selected files"; }
        { on = [ "X" ]; run = "unyank"; desc = "Cancel the yank status of files"; }
        { on = [ "p" ]; run = "paste"; desc = "Paste the files"; }
        { on = [ "P" ]; run = "paste --force"; desc = "Paste the files (overwrite if the destination exists)"; }
        { on = [ "-" ]; run = "link"; desc = "Symlink the absolute path of files"; }
        { on = [ "—" ]; run = "link --relative"; desc = "Symlink the relative path of files"; }
        { on = [ "d" ]; run = "remove --permanently"; desc = "Delete the files"; }  # I don't use the trash, use permanent delete by default.
        { on = [ "a" ]; run = "create"; desc = "Create a file or directory (ends with / for directories)"; }
        { on = [ "r" ]; run = "rename --cursor=before_ext"; desc = "Rename a file or directory"; }


        # extra operations

        { on = [ ":" ]; run = "shell --interactive --block"; desc = "Run a shell command (block until command finishes)"; }
        { on = [ ";" ]; run = "shell --interactive"; desc = "Run a shell command"; }


        # copying paths

        { on = [ "," "c" ]; run = "copy path"; desc = "Copy the absolute path"; }
        { on = [ "," "d" ]; run = "copy dirname"; desc = "Copy the path of the parent directory"; }
        { on = [ "," "f" ]; run = "copy filename"; desc = "Copy the name of the file"; }
        { on = [ "," "n" ]; run = "copy name_without_ext"; desc = "Copy the name of the file without the extension"; }


        # filtering and searching

        { on = [ "/" ]; run = "find --smart"; desc = "Find next file"; }
        { on = [ "?" ]; run = "find --previous --smart"; desc = "Find previous file"; }
        { on = [ "n" ]; run = "find_arrow"; desc = "Go to next found file"; }
        { on = [ "N" ]; run = "find_arrow --previous"; desc = "Go to previous found file"; }
        { on = [ "s" ]; run = "search fd"; desc = "Search files by name using fd"; }
        { on = [ "S" ]; run = "search rg"; desc = "Search files by content using ripgrep"; }
        { on = [ "<C-s>" ]; run = "search none"; desc = "Cancel the ongoing search"; }


        # exiting

        { on = [ "<Esc>" ]; run = "escape"; desc = "Exit visual mode, clear selected, or cancel search"; }
        { on = [ "q" ]; run = "quit"; desc = "Exit the process"; }
        { on = [ "Q" ]; run = "quit --no-cwd-file"; desc = "Exit the process without writing cwd-file"; }


        # misc

        { on = [ "." ]; run = "hidden toggle"; desc = "Toggle the visibility of hidden files"; }
        { on = [ "w" ]; run = "tasks_show"; desc = "Show the tasks manager"; }
        { on = [ "h" ]; run = "help"; desc = "Open help"; }

      ];
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
    extraLuaConfig = ''
      vim.g.mapleader = ' '
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true
      vim.bo.softtabstop = 2
      vim.keymap.set('n', '<leader><Tab>', '<cmd>b#<cr>', { desc = 'Switch to last used buffer' })
    '';
    coc = {
      enable = true;
    };
    plugins = with pkgs.vimPlugins; [
      zephyr-nvim
      plenary-nvim
      {
        plugin = telescope-nvim;
        config = ''
          local builtin = require('telescope.builtin')
          vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
          vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
          vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
          vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
        '';
        type = "lua";
      }
      {
        plugin = yazi-nvim;
        config = ''
          require('yazi').setup({
            open_for_directories = true,
            keymaps = {
              show_help = '<f1>',
            },
          }) 
          vim.keymap.set('n', '<leader>e', '<cmd>Yazi cwd<cr>', { desc = 'Open file explorer'})
        '';
        type = "lua";
      }
      {
        plugin = yanky-nvim;
        config = ''
        '';
      }
      {
        plugin = which-key-nvim;
        config = ''
          vim.keymap.set('n', "<leader>?", function() require("which-key").show({ global = false }) end, { desc = "Buffer Local Keymaps (which-key)"}) 
        '';
        type = "lua";
      }
      plenary-nvim
      telescope-nvim
      telescope-fzf-native-nvim
      nvim-treesitter
    ];
  };
}
