{ pkgs, config, ... }:

{
  home.packages = [
    pkgs.goimapnotify
  ];

  home.file.".config/goimapnotify/goimapnotify.conf".source = ./dotfiles/goimapnotify.conf;

  systemd.user.services."goimapnotify" = {
    Unit = {
      Description = "Use goimapnotify to sync inboxes on incoming mail";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      SyslogIdentifier = "goimapnotify-service";
      Type = "simple";
      Restart = "always";
      RestartSec = 5;
      ExecStart = toString (
        pkgs.writeShellScript "goimapnotify-start-script.sh" ''
          ${pkgs.goimapnotify}/bin/goimapnotify -conf ${config.home.homeDirectory}/.config/goimapnotify/goimapnotify.conf
        ''
      );
    };
  };

}
