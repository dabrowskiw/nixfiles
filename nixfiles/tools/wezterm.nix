{ pkgs, ... }:

{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
        local wezterm = require 'wezterm'

        local config = wezterm.config_builder()

        -- The filled in variant of the < symbol
        local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

        -- The filled in variant of the > symbol
        local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

        -- This function returns the suggested title for a tab.
        -- It prefers the title that was set via `tab:set_title()`
        -- or `wezterm cli set-tab-title`, but falls back to the
        -- title of the active pane in that tab.
        function tab_title(tab_info)
          local title = tab_info.tab_title
          -- if the tab title is explicitly set, take that
          if title and #title > 0 then
            return title
          end
          -- Otherwise, use the title from the active pane
          -- in that tab
          return tab_info.active_pane.title
        end

        wezterm.on(
          'format-tab-title',
          function(tab, tabs, panes, config, hover, max_width)
            local edge_background = '#0b0022'
            local background = '#1b1032'
            local foreground = '#808080'

            if tab.is_active then
              background = '#2b2042'
              foreground = '#c0c0c0'
            elseif hover then
              background = '#3b3052'
              foreground = '#909090'
            end

            local edge_foreground = background

            local title = tab_title(tab)

            -- ensure that the titles fit in the available space,
            -- and that we have room for the edges.
            title = wezterm.truncate_right(title, max_width - 2)

            return {
              { Background = { Color = edge_background } },
              { Foreground = { Color = edge_foreground } },
              { Text = SOLID_LEFT_ARROW },
              { Background = { Color = background } },
              { Foreground = { Color = foreground } },
              { Text = title },
              { Background = { Color = edge_background } },
              { Foreground = { Color = edge_foreground } },
              { Text = SOLID_RIGHT_ARROW },
            }
          end
        )

        wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
          return 'WezTerm'
        end)

        config.leader = { key = 'b', mods = 'CTRL' }
        config.quick_select_patterns = {
          '[^\\s@]+@[^\\s@]+\\.[^\\s@]+',
        }
        config.keys = {
          {
            key = 'Tab',
            mods = 'LEADER',
            action = wezterm.action.ActivateLastTab,
          },
          {
            key = 'p',
            mods = 'LEADER',
            action = wezterm.action.ActivateTabRelative(-1),
          },
          {
            key = 'n',
            mods = 'LEADER',
            action = wezterm.action.ActivateTabRelative(1),
          },
          {
            key = 'f',
            mods = 'LEADER',
            action = wezterm.action.QuickSelect,
          },
          {
            key = 'v',
            mods = 'LEADER',
            action = wezterm.action.ActivateCopyMode,
          },
          {
            key = 't',
            mods = 'LEADER',
            action = wezterm.action.SpawnTab 'CurrentPaneDomain',
          },
          {
            key = 'c',
            mods = 'LEADER',
            action = wezterm.action.SpawnTab 'CurrentPaneDomain',
          },
          {
            key = 'w',
            mods = 'LEADER',
            action = wezterm.action.CloseCurrentTab { confirm = false },
          },
          {
            key = 'e',
            mods = 'LEADER',
            action = wezterm.action.CharSelect {
              copy_on_select = true,
              copy_to = 'ClipboardAndPrimarySelection',
              group = 'SmileysAndEmotion',
            },
          },
        }

        return config
    '';
  };
}
