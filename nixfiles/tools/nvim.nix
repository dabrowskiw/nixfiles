{ pkgs, lib, ... }: 

let 
  vimspectorpy = pkgs.vimUtils.buildVimPlugin {
    name = "vim-vimspectorpy";
    src = pkgs.fetchFromGitHub {
      owner = "sagi-z";
      repo = "vimspectorpy";
      rev = "a56aaeb6a61ddcd48d0900581115d89aa92d6f74";
      hash = "sha256-bLe2men48CfVYonl5KN+qpbGW8RJI4vQSQy6CSZ4ZmE=";
    };
  };
  nextflow-vim = pkgs.vimUtils.buildVimPlugin {
    name = "nextflow-vim";
    src = pkgs.fetchFromGitHub {
      owner = "LukeGoodsell";
      repo = "nextflow-vim";
      rev = "3b77c4c329dcfb81c9cc5e10daeb3f9752c51d73";
      hash = "sha256-bLe2men48CfVYonl5KN+qpbGW8RJI4vQSQy6CSZ4ZmE=";
    };
  };
in
{

  home.packages = [
    pkgs.bat
    pkgs.ripgrep
    pkgs.tinymist
    pkgs.websocat
    pkgs.slint-lsp
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
    extraPython3Packages = (ps: with ps; [
      setuptools
      debugpy
      ipython
    ]);
    extraLuaConfig = ''
      vim.g.mapleader = ' '
      vim.opt.clipboard="unnamedplus"
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true
      vim.opt.relativenumber = true
      vim.opt.termguicolors = true
      vim.opt.spelllang = "en_us,de_de"
      vim.opt.spell = true
      vim.opt.number = true
      vim.opt.whichwrap:append({ ['<'] = true, ['>'] = true, ['h'] = true, ['l'] = true, ['['] = true, [']'] = true })
      vim.bo.softtabstop = 2
      vim.keymap.set('n', '<leader><Tab>', '<cmd>b#<cr>', { desc = 'Switch to last used buffer' })
      vim.keymap.set('i', '<Down>', "v:count ? '<C-o>j' : '<C-o>gj'", { expr = true, noremap = true, silent = true })
      vim.keymap.set('i', '<Up>', "v:count ? '<C-o>k' : '<C-o>gk'", { expr = true, noremap = true, silent = true })
      vim.keymap.set('n', '<Down>', "v:count ? 'j' : 'gj'", { expr = true, noremap = true })
      vim.keymap.set('n', '<Up>', "v:count ? 'k' : 'gk'", { expr = true, noremap = true })
      vim.keymap.set('n', '<leader>De', '<cmd>lua vim.diagnostic.open_float()<cr>', { desc = "Show LSP diagnostic message"})
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern={"*.slint"}, 
        callback=function()
          vim.opt.filetype = "slint"
        end
      })
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          vim.fn.setreg("/", "")
        end,
      })
    '';
    coc = {
      enable = true;
      settings = ''
        "languageserver": {
      }
     '';
    };
    plugins = with pkgs.vimPlugins; [
      {
        plugin = nextflow-vim;
      }
      {
        plugin = nvim-treesitter-parsers.groovy;
      }
      {
        plugin = fastaction-nvim;
        config = ''
          require("fastaction").setup {
            dismiss_keys = { "j", "k", "<c-c>", "q" },
            override_function = function(_) end,
            keys = "qwertyuiopasdfghlzxcvbnm",
            popup = {
              border = "rounded",
              hide_cursor = true,
              highlight = {
                divider = "FloatBorder",
                key = "MoreMsg",
                title = "Title",
                window = "NormalFloat",
              },
              title = "Select one of:",
            },
            priority = {
              -- dart = {
              --   { pattern = "organize import", key ="o", order = 1 },
              --   { pattern = "extract method", key ="x", order = 2 },
              --   { pattern = "extract widget", key ="e", order = 3 },
              -- },
            },
           register_ui_select = false,
          }
          vim.keymap.set(
            { 'n', 'x' },
            '<leader>a',
            '<cmd>lua require("fastaction").code_action()<CR>',
            { buffer = bufnr }
          )
        '';
        type = "lua";
      }
      vCoolor-vim
      colorizer
      {
        plugin = vim-pencil;
        config = ''
          set nocompatible
          filetype plugin on
          let g:pencil#wrapModeDefault = 'soft' 

          augroup pencil
            autocmd!
            autocmd FileType markdown,mkd call pencil#init()
            autocmd FileType text,txt     call pencil#init()
            autocmd FileType eml          call pencil#init()
          augroup END
        '';
      }

      {
        plugin = nvim-lspconfig;
        config = ''
          local lspconfig = require("lspconfig")
          lspconfig.tinymist.setup{
            single_file_support = true,
            offset_encoding = "utf-8",
            settings = {
              exportPdf = "onSave",
            },
          }
          lspconfig.slint_lsp.setup{}
        '';
        type = "lua";
      }
      {
        plugin = telescope-nvim;
        config = ''
          local builtin = require('telescope.builtin')
          vim.keymap.set('n', '<C-f>f', builtin.find_files, { desc = 'Telescope find files' })
          vim.keymap.set('n', '<C-f>g', builtin.live_grep, { desc = 'Telescope live grep' })
          vim.keymap.set('n', '<C-f>b', builtin.buffers, { desc = 'Telescope buffers' })
          vim.keymap.set('n', '<C-f>h', builtin.command_history, { desc = 'Telescope command history' })
          vim.keymap.set('i', '<C-f>f', builtin.find_files, { desc = 'Telescope find files' })
          vim.keymap.set('i', '<C-f>g', builtin.live_grep, { desc = 'Telescope live grep' })
          vim.keymap.set('i', '<C-f>b', builtin.buffers, { desc = 'Telescope buffers' })
          vim.keymap.set('i', '<C-f>h', builtin.command_history, { desc = 'Telescope command history' })
        '';
        type = "lua";
      }
      telescope-fzf-native-nvim
      {
        plugin = telescope-symbols-nvim;
        type = "lua";
        config = ''
          local builtin = require('telescope.builtin')
          vim.keymap.set('n', '<C-f>e', function() 
            builtin.symbols{ sources = {'emoji'} }
          end, { desc = 'Telescope find emojis' })
          vim.keymap.set('i', '<C-f>e', function()
            builtin.symbols{ sources = {'emoji'} }
          end, { desc = 'Telescope find emojis' })
        '';
      }
      {
        plugin = vimspector;
        config = ''
            vim.g.vimspector_enable_mappings = "HUMAN"
            vim.g.vimspector_base_dir = "/home/wojtek/.config/vimspector-config"
            vim.g["vimspector_sign_priority"]= {
              vimspectorBP=39,
              vimspectorBPCon=38,
              vimspectorBPLog=37,
              vimspectorBPDisabled=36,
              vimspectorPC=999,
            }
            vim.keymap.set('n', '<leader>Dd', "<Plug>VimspectorContinue", { desc = 'start Debugging (F5)' })
            vim.keymap.set('n', '<leader>Dc', "<Plug>VimspectorRunToCursor", { desc = 'run to Cursor (<leader>F8)' })
            vim.keymap.set('n', '<leader>Dx', "<cmd>VimspectorReset<cr>", { desc = 'eXit debugger (F3)' })
            vim.keymap.set('n', '<leader>Dr', "<Plug>VimspectorRestart", { desc = 'Restart debugger (F4)' })
            vim.keymap.set('n', '<leader>Db', "<Plug>VimspectorToggleBreakpoint", { desc = 'toggle line Breakpoint' })
            vim.keymap.set('n', '<leader>DB', "<Plug>VimspectorToggleConditionalBreakpoint", { desc = 'toggle conditional Breakpoint' })
            vim.keymap.set('n', '<leader>Do', "<Plug>VimspectorStepOver", { desc = 'step Over (F9)' })
            vim.keymap.set('n', '<leader>Dn', "<Plug>VimspectorStepInto", { desc = 'step iNto (F11)' })
            vim.keymap.set('n', '<leader>Du', "<Plug>VimspectorStepOut", { desc = 'step oUt (F12)' })
            vim.keymap.set('n', '<leader>Di', "<Plug>VimspectorBalloonEval", { desc = 'Inspect (F7)' })
            vim.keymap.set('n', '<F7>', "<Plug>VimspectorBalloonEval")
            vim.keymap.set('n', '<F3>', "<Plug>VimspectorReset")
            vim.keymap.set('n', '<F9>', "<Plug>VimspectorReset")
        '';
        type = "lua";
      }
      {
        plugin = vimspectorpy;
        config = ''
          let g:vimspectorpy_home = "/home/wojtek/.config/vimspectorpy"
          let g:vimspectorpy_venv = "/home/wojtek/.config/vimspectorpy/venv"
        '';
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
      {
        plugin = typst-preview-nvim;
        type = "lua";
        config = ''
          require('typst-preview').setup {
          -- Custom format string to open the output link provided with %s
          -- Example: open_cmd = 'firefox %s -P typst-preview --class typst-preview'
          open_cmd = nil,

          invert_colors = 'never',

          follow_cursor = true,

          -- Provide the path to binaries for dependencies.
          -- Setting this will skip the download of the binary by the plugin.
          -- Warning: Be aware that your version might be older than the one
          -- required.
          dependencies_bin = {
            ['tinymist'] = '${pkgs.tinymist}/bin/tinymist',
            ['websocat'] = '${pkgs.websocat}/bin/websocat' 
          },

          extra_args = nil,

          get_root = function(path_of_main_file)
            local root = os.getenv 'TYPST_ROOT'
            if root then
              return root
            end
            return vim.fn.fnamemodify(path_of_main_file, ':p:h')
          end,

          get_main_file = function(path_of_buffer)
            return path_of_buffer
          end,
        }
        '';
      }
      plenary-nvim
      nvim-treesitter
      nvim-treesitter-parsers.typst
      {
        plugin = lualine-nvim;
        type = "lua";
        config = ''
          require("lualine").setup {
            theme = "onedark",
          }
        '';
      }
      # Colorscheme
      {
        plugin = onedark-nvim;
        type = "lua";
        config = ''
          require("onedark").setup {
            style = "warmer",
            ending_tildes = true,
          }
          require("onedark").load()
        '';
      }
      # slint
      {
        plugin = nvim-treesitter-parsers.slint;

      }
    ];
  };
}
