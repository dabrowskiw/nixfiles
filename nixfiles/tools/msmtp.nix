{ pkgs, ...}:
{
  home.packages = [
    pkgs.msmtp
  ];

  programs.mbsync.enable = true;
  programs.msmtp.enable = true;
  programs.notmuch = {
    enable = true;
#    hooks = {
#      preNew = "mbsync --all";
#    };
  };
  accounts.email.accounts.htw = {
    primary = true;
    address = "Piotr.Dabrowski@htw-berlin.de";
    realName = "Prof. Dr.-Ing. Piotr Wojciech Dabrowski";
    userName = "dabrows";
    passwordCommand = "pass Email/piotr.dabrowski@htw-berlin.de";
    imap.host = "imap.htw-berlin.de";
    smtp = {
      host = "smtp.htw-berlin.de";
    };
    mbsync = {
      enable = true;
      create = "maildir";
      expunge = "both";
      groups.htw.channels = {
        inbox = {
          farPattern = "INBOX";
        };
        all = {
          farPattern = "";
          nearPattern = "";
          patterns = [
            "*"
          ];
        };
      };
    };
    notmuch.enable = true;
    msmtp = {
      enable = true;
      extraConfig = {
        tls_starttls = "on";
        port = "587";
        host = "smtp.htw-berlin.de";
        from = "Piotr.Dabrowski@htw-berlin.de";
        user = "dabrows";
        passwordeval = "pass Email/piotr.dabrowski@htw-berlin.de";
      };
    };
  };
  accounts.email.accounts.posteo = {
    primary = false;
    address = "Piotr.Dabrowski@posteo.de";
    realName = "Wojtek Dabrowski";
    userName = "Piotr.Dabrowski@posteo.net";
    passwordCommand = "pass Email/piotr.dabrowski@posteo.de";
    imap.host = "posteo.de";
    smtp = {
      host = "posteo.de";
    };
    mbsync = {
      enable = true;
      create = "maildir";
      expunge = "both";
      groups.posteo.channels = {
        inbox = {
          farPattern = "INBOX";
        };
        all = {
          farPattern = "";
          nearPattern = "";
          patterns = [
            "*"
          ];
        };
      };
    };
    notmuch.enable = true;
    msmtp = {
      enable = true;
      extraConfig = {
        tls_starttls = "on";
        port = "587";
        host = "smtp.posteo.de";
        from = "Piotr.Dabrowski@posteo.de";
        user = "Piotr.Dabrowski@posteo.net";
        passwordeval = "pass Email/piotr.dabrowski@posteo.de";
      };
    };
  };
}
