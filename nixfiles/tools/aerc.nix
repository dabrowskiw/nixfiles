{ pkgs, pkgs-unstable, lib, config, ... }:

let 
  formatmail = pkgs.writeTextFile {
    name = "formatmail";
    destination = "/bin/formatmail";
    executable = true;
    text = (builtins.readFile ../../scripts/formatmail);
  };
  mail2gutachten = pkgs.writeTextFile {
    name = "mail2gutachten";
    destination = "/bin/mail2gutachten";
    executable = true;
    text = (builtins.readFile ../../scripts/mail2gutachten);
  };
  addContact = pkgs.writeTextFile {
    name = "addContact";
    destination = "/bin/addContact";
    executable = true;
    text = (builtins.readFile ../../scripts/addContact);
  };
  khal_config = pkgs.writeTextFile {
    name = "khal_config";
    destination = "/share/khal.config";
    text = ''
      [calendars]
      [[Posteo]]
      path = ~/data/calendars/Posteo/default/

      [[Müllabfuhr]]
      path = ~/data/calendars/Posteo/aarvay/

      [[Geburtstage]]
      path = ~/data/calendars/Posteo/oqzfeh/

      [[Vorlesungen]]
      path = ~/data/calendars/HTW-calendar/Y2FsOi8vMC8yMDk1Mg/

      [[HTW]]
      path = ~/data/calendars/HTW-calendar/Y2FsOi8vMC8yMDgwMg/

      [[Personal]]
      path = ~/data/calendars/HTW-calendar/Y2FsOi8vMC8zMTg3MA/

      [sqlite]
      path = ~/.khal/khal.db

      [locale]
      local_timezone = Europe/Berlin
      default_timezone = America/New_York

      # If you use certain characters (e.g. commas) in these formats you may need to
      # enclose them in "" to ensure that they are loaded as strings.
      timeformat = %H:%M
      dateformat = %d.%m.
      longdateformat = %d.%m.%Y
      datetimeformat =  %d.%m. %H:%M
      longdatetimeformat = %d.%m.%Y %H:%M

      firstweekday = 0
      weeknumbers = "left"

      [default]
      default_calendar = HTW
      timedelta = 2d # the default timedelta that list uses
      highlight_event_days = True  # the default is False

      [keybindings]
      external_edit = x
    '';
  };
  mail_vimrc = pkgs.writeTextFile {
    name = "mail_vimrc";
    destination = "/share/mail.vimrc";
    text = ''
      set linebreak
      set spell spelllang=en_gb,de_de,pl
      set spell

      set spellfile=~/.vim/custom.utf-8.add

      set textwidth=80
      set wrapmargin=0
      set breakindent
      set formatoptions+=lt
      set lbr
      set expandtab
      set ft=mail

      set hlsearch
      set autoindent
      set clipboard=unnamed

      hi mailQuoted1 guifg=#e6bdff
      hi mailQuoted2 guifg=#8573ff
      hi mailQuoted3 guifg=#2977ff
      hi mailQuoted4 guifg=#00bfde
      hi mailQuoted5 guifg=#009460
    '';
  };
  htwsignature = pkgs.writeTextFile {
    name = "htwsignature";
    destination = "/share/HTW.signature";
    text = ''
-- 
Prof. Dr.-Ing. Piotr Wojciech Dabrowski
Hochschule für Technik und Wirtschaft (HTW) Berlin
Wilhelminenhofstr. 75A
Gebäude C, Raum 614
D-12459 Berlin
+49 30 5019-3397
Piotr.Dabrowski@HTW-Berlin.de | www.htw-berlin.de'';
  };
  aercfiles = pkgs.writeTextFile {
    name = "aerc_files";
    text = ''All mail=tag:inbox'';
    destination = "/share/map.conf";
  };
  exportics = pkgs.writeTextFile {
    name = "exportics";
    executable = true;
    destination = "/bin/exportics";
    text = ''
      #!/usr/bin/env fish

      set -l infile /tmp/(uuidgen).ics
      cp $argv[1] $infile
      set -l name (grep "SUMMARY" $infile | head -n 1 | cut -d ":" -f 2 | sed 's/\r//g')
      set -l mails (sed ':a; N; $!ba; s/ *\r\n *//g' $infile | sed 's/ATTENDEE/\n/g' | grep "EMAIL" | sed 's/^.*EMAIL=//g' | cut -d ";" -f 1 | cut -d ":" -f 1 | sort | uniq | paste -sd ",")
      aerc "mailto:$mails?account=Posteo&subject=Termineinladung: $name" && aerc :attach $infile
    '';
  };
  runikhal = pkgs.writeShellApplication {
    name = "runikhal";
    text = ''
      export EDITOR="fish ${exportics}/bin/exportics"
      ikhal -c ${khal_config}/share/khal.config -a HTW -a Vorlesungen -a Personal -a Müllabfuhr -a Geburtstage -a Posteo
      aerc :next-tab 
    '';
  };
  inbox-sync = pkgs.writeShellApplication {
    name = "inbox-sync";
    runtimeInputs = [ pkgs.notmuch pkgs.isync ];
    bashOptions = [];
    text = ''
      MBSYNC=$(pgrep mbsync)
      NOTMUCH=$(pgrep notmuch)

      if [[ -n $MBSYNC && -n $NOTMUCH ]]; then
          echo "Already running one instance of mbsync or notmuch. Exiting."
          exit 0
      fi

      echo "Deleting messages tagged as *deleted*"
      notmuch search --format=text0 --output=files tag:deleted | xargs -0 --no-run-if-empty rm -v

      mbsync -V htw-inbox
      mbsync -V posteo-inbox
      notmuch new
    '';
  };

in
{
  home.packages = [
    runikhal
    formatmail
    mail2gutachten
    addContact
    inbox-sync
    aercfiles
    htwsignature
    mail_vimrc
  ];

  programs.aerc = {
    enable = true;
    package = pkgs-unstable.aerc;
    extraConfig = {
      general.unsafe-accounts-conf = true;
      ui = {
        new-message-bell = "false";
        dirlist-right = "{{if match .Folder `INBOX`}}{{humanReadable .Exists}}{{end}}";
        dirlist-tree = "true"; 
        dirlist-collapse = "1";
        next-message-on-delete = "false";
        fuzzy-complete = "true";
        completion-min-chars = "2";
        threading-enabled = "true";

      };
      viewer = {
        pager = "nvimpager - -S ${mail_vimrc}/share/mail.vimrc -c \"set nospell\""; 
        alternatives = "text/plain,text/html";
        parse-http-links = true;
      }; 
      compose = {
        address-book-cmd = "khard email --parsable --search-in-source-files --remove-first-line %s";
        reply-to-self = "false";
        editor = "vim -S ${mail_vimrc}/share/mail.vimrc -c \"au VimEnter * :%!formatmail\"";
        file-picker-cmd = "broot /home/wojtek/";
      };
      filters = {
        "text/plain" = "formatmail";
        "text/calendar" = "calendar";
        "message/delivery-status" = "colorize";
        "message/rfc822" = "colorize";
        "text/html" = "html";
        "application/msword" = "catdoc";
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "catdoc";
      };
      openers = {
        "text/html" = "firefox";
        "image/*" = "qimgv";
        "application/pdf" = "masterpdfeditor4";
        "application/ics" = "contour -e khal -c ${khal_config}/share/khal.config import ";
        "text/calendar" = "contour -e khal -c ${khal_config}/share/khal.config import ";
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "abiword";
      };
      hooks = {
        aerc-startup = "aerc :terminal runikhal";
        mail-sent = "addContact $AERC_TO";
      };
      templates = {
        forwards = "forward_quoted";
      };
    };
    extraBinds = {
      view = {
        "/" = ":toggle-key-passthrough<Enter>/";
        "q" = ":close<Enter>";
        "O" = ":open<Enter>";
        "S" = ":menu -c 'fzf --walker=dir --walker-root=/home/wojtek/' :save<Enter>";
        "s" = ":save<space>";
        "|" = ":pipe<space>";
        "D" = ":delete<Enter>";
        "A" = ":archive flat<Enter>";

        "<C-l>" = ":open-link <space>";

        "f" = ":forward<Enter>";
        "F" = ":forward -A<Enter>";
        "rr" = ":reply -a<Enter>";
        "rq" = ":reply -aq<Enter>";
        "Rr" = ":reply<Enter>";
        "Rq" = ":reply -q<Enter>";
        "Gm" = ":pipe -m mail2gutachten master";
        "Gb" = ":pipe -m mail2gutachten bachelor";

        "H" = ":toggle-headers<Enter>";
        "<C-k>" = ":prev-part<Enter>";
        "<C-j>" = ":next-part<Enter>";
        "m" = ":menu -dc fzf :mv <Enter>";
        "<C-p>" = ":prev-tab<Enter>";
        "<C-n>" = ":next-tab<Enter>";
        "<C-PgUp>" = ":prev-tab<Enter>";
        "<C-PgDn>" = ":next-tab<Enter>";
      };
      messages = {
        "<C-p>" = ":prev-tab<Enter>";
        "<C-n>" = ":next-tab<Enter>";
        "<C-PgUp>" = ":prev-tab<Enter>";
        "<C-PgDn>" = ":next-tab<Enter>";
        "<C-t>" = ":term<Enter>";
        "q" = ":quit<Enter>";

        "m" = ":menu -dc fzf :mv <Enter>";
        "M" = ":read<Enter>";

        "j" = ":next<Enter>";
        "<Down>" = ":next<Enter>";
        "<C-d>" = ":next 50%<Enter>";
        "<C-f>" = ":next 100%<Enter>";
        "<PgDn>" = ":next 100%<Enter>";

        "k" = ":prev<Enter>";
        "<Up>" = ":prev<Enter>";
        "<C-u>" = ":prev 50%<Enter>";
        "<C-b>" = ":prev 100%<Enter>";
        "<PgUp>" = ":prev 100%<Enter>";
        "g" = ":select 0<Enter>";
        "G" = ":select -1<Enter>";

        "H" = ":collapse-folder<Enter>";
        "L" = ":expand-folder<Enter>";

        "v" = ":mark -t<Enter>";
        "V" = ":mark -v<Enter>";

        "t" = ":mark -T<Enter>";
        "T" = ":toggle-threads<Enter>";

        "<Enter>" = ":view<Enter>";
        "d" = ":prompt 'Really delete this message?' 'delete-message'<Enter>";
        "D" = ":delete<Enter>";
        "A" = ":archive flat<Enter>";

        "C" = ":compose<Enter>";

        "rr" = ":reply -a<Enter>";
        "rq" = ":reply -aq<Enter>";
        "Rr" = ":reply<Enter>";
        "Rq" = ":reply -q<Enter>";

        "c" = ":menu -dc fzf :cf <Enter>";
        "i" = ":cf Inbox<Enter>";
        "S" = ":term vdirsyncer sync<Enter>";
        "I" = ":term inbox-sync sync<Enter>";
        "$" = ":term<space>";
        "!" = ":term<space>";
        "|" = ":pipe<space>";

        "/" = ":filter -b<space>";
        "\\f" = ":filter -f<space>";
        "\\b" = ":filter -b<space>";
        "\\a" = ":filter -a<space>";
        "n" = ":next-result<Enter>";
        "N" = ":prev-result<Enter>";
        "<Esc>" = ":clear<Enter>";
      };
      "messages:folder=Drafts" = {
        "<Enter>" = ":recall<Enter>";
      };
      "view::passthrough" = {
        "$noinherit" = "true";
        "$ex" = "<C-x>";
        "<Esc>" = ":toggle-key-passthrough<Enter>";
      };
      "compose" = {
        "$noinherit" = "true";
        "$ex" = "<C-x>";
        "<C-k>" = ":prev-field<Enter>";
        "<C-j>" = ":next-field<Enter>";
        "<A-p>" = ":switch-account -p<Enter>";
        "<A-n>" = ":switch-account -n<Enter>";
        "<C-c>" = ":cc<Enter>";
        "<C-b>" = ":bcc<Enter>";
        "<tab>" = ":next-field<Enter>";
        "<backtab>" = ":prev-field<Enter>";
        "<C-p>" = ":prev-tab<Enter>";
        "<C-n>" = ":next-tab<Enter>";
        "<C-PgUp>" = ":prev-tab<Enter>";
        "<C-PgDn>" = ":next-tab<Enter>";
      };
      "compose::editor" = {
        "$noinhert" = "true";
        "$ex" = "<C-x>";
        "<C-k>" = ":prev-field<Enter>";
        "<C-j>" = ":next-field<Enter>";
        "<C-p>" = ":prev-tab<Enter>";
        "<C-n>" = ":next-tab<Enter>";
        "<C-PgUp>" = ":prev-tab<Enter>";
        "<C-PgDn>" = ":next-tab<Enter>";
        "<C-a>" = ":attach<space>";
        "<C-q>" = ":abort";
      };
      "compose::review" = {
        "y" = ":send<Enter>";
        "n" = ":abort<Enter>";
        "v" = ":preview<Enter>";
        "p" = ":postpone<Enter>";
        "q" = ":choose -o d discard abort -o p postpone postpone<Enter>";
        "e" = ":edit<Enter>";
        "a" = ":attach -m<Enter>";
        "A" = ":attach<space>";
        "d" = ":detach<space>";
        "<C-p>" = ":prev-tab<Enter>";
        "<C-n>" = ":next-tab<Enter>";
        "<C-PgUp>" = ":prev-tab<Enter>";
        "<C-PgDn>" = ":next-tab<Enter>";
      };
      "terminal" = {
        "$noinherit" = "true";
        "$ex" = "<C-x>";
        "<C-p>" = ":prev-tab<Enter>";
        "<C-n>" = ":next-tab<Enter>";
        "<C-PgUp>" = ":prev-tab<Enter>";
        "<C-PgDn>" = ":next-tab<Enter>";
      };

    };
    templates = {
      forward_quoted = ''

Forwarded message from {{(index .OriginalFrom 0).Name}} on {{dateFormat .OriginalDate "Mon Jan 2, 2006 at 3:04 PM"}}:

{{.OriginalText | quote}}
      '';
      gutachten = ''

      '';
    };
    extraAccounts = {
      HTW = {
        source = "maildir://~/Maildir/htw/";
        outgoing-cred-cmd = "pass Email/piotr.dabrowski@htw-berlin.de";
        outgoing = "smtp+plain://dabrows@smtp.htw-berlin.de:587";
        default  = "Inbox";
        folders-sort = "Inbox";
        from     = "Prof. Dr.-Ing. Piotr Wojciech Dabrowski <Piotr.Dabrowski@htw-berlin.de>";
        aliases  = "Prof. Dr.-Ing. Piotr Wojciech Dabrowski <dabrows@htw-berlin.de>, \"Piotr Wojciech Dabrowski\" <Piotr.Dabrowski@HTW-Berlin.de>, \"Prof. Dr.-Ing. Piotr Wojciech Dabrowski\" <Piotr.Dabrowski@HTW-Berlin.de>";
        copy-to  = "Inbox";
        pgp-auto-sign = "false ";
        pgp-key-id = "46107DC46CA695F7";
        signature-file = "${htwsignature}/share/HTW.signature";
      };

      Posteo = {
        source = "maildir://~/Maildir/posteo";
        outgoing-cred-cmd = "pass Email/piotr.dabrowski@posteo.de";
        outgoing = "smtp+plain://Piotr.Dabrowski%40posteo.net@posteo.de:587";
        default  = "Inbox";
        folders-sort = "Inbox";
        from     = "Piotr Dabrowski <Piotr.Dabrowski@posteo.de>";
        copy-to  = "Inbox";
        pgp-auto-sign = "false";
        pgp-key-id = "46107DC46CA695F7";
      };

      search = {
        source    = "notmuch://~/Maildir/";
        from = "Nobody <none@none.com>";
        default = "Inbox";
        query-map = "${aercfiles}/share/map.conf";
      };
    };
  };

}
