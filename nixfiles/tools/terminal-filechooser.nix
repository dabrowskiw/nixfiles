{ config, lib, pkgs, ... }:

let
  portal = pkgs.xdg-desktop-portal-termfilechooser;
  yazi = config.programs.yazi.package;

  terminalCommand =
    "${lib.getExe pkgs.kitty} --class yazi-filechooser";

  runtimePath = lib.makeBinPath [
    yazi
    pkgs.fd
    pkgs.fzf
    pkgs.kitty
    pkgs.coreutils
    pkgs.gnused
    pkgs.gnugrep
    pkgs.findutils
    pkgs.bashInteractive
  ];

  chooser = pkgs.writeShellScript "yazi-portal-chooser" ''
    export PATH=${lib.escapeShellArg runtimePath}''${PATH:+:$PATH}
    export TERMCMD=${lib.escapeShellArg terminalCommand}

    exec ${pkgs.bash}/bin/bash \
      ${portal}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh \
      "$@"
  '';

  directoryPicker = pkgs.writeShellScript "yazi-directory-picker" ''
    unset FZF_DEFAULT_COMMAND FZF_DEFAULT_OPTS

    ${lib.getExe pkgs.fd} \
      --type d \
      --hidden \
      --exclude .git \
      --absolute-path \
      --print0 \
      . \
    | ${lib.getExe pkgs.fzf} \
        --read0 \
        --print0 \
        --no-multi \
        --prompt='Directory> '
  '';
in
{
  programs.yazi = {
    enable = true;

    keymap.mgr.prepend_keymap = [
      {
        on = [ "z" "d" ];
        run = "plugin directory-picker";
        desc = "Fuzzy-find a directory";
      }
      {
        on = [ "z" "f" ];
        run = "plugin fzf";
        desc = "Fuzzy-find a file";
      }
    ];
  };

  xdg.configFile."xdg-desktop-portal-termfilechooser/config".text = ''
    [filechooser]
    cmd=${chooser}
    default_dir=${config.home.homeDirectory}
    open_mode=suggested
    save_mode=suggested
  '';

  xdg.configFile."yazi/plugins/directory-picker.yazi/main.lua".text = ''
    local get_cwd = ya.sync(function()
      return tostring(cx.active.current.cwd)
    end)

    return {
      entry = function()
        local cwd = get_cwd()
        local permit = ui.hide()

        local child, err = Command("${lib.getExe pkgs.fzf}")
          :arg({
            "--walker=dir,follow",
            "--no-multi",
            "--prompt=Directory> ",
          })
          :env("FZF_DEFAULT_COMMAND", "")
          :env("FZF_DEFAULT_OPTS", "")
          :cwd(cwd)
          :stdin(Command.INHERIT)
          :stdout(Command.PIPED)
          :stderr(Command.INHERIT)
          :spawn()

        if not child then
          permit:drop()
          ya.notify {
            title = "Directory picker",
            content = tostring(err),
            level = "error",
            timeout = 5,
          }
          return
        end

        local output, wait_err = child:wait_with_output()
        permit:drop()

        if not output then
          ya.notify {
            title = "Directory picker",
            content = tostring(wait_err),
            level = "error",
            timeout = 5,
          }
          return
        end

        if not output.status.success then
          return
        end

        local path = output.stdout:gsub("\n$", "")
        if path ~= "" then
          if path:sub(1, 1) ~= "/" then
            path = cwd .. "/" .. path
          end
          ya.emit("cd", { path })
        end
      end,
    }
  '';

}
