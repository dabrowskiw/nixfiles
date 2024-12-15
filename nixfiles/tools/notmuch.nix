{ pkgs, ... }:

let
  notmuchconfig = pkgs.writeTextFile {
    name = "notmuchconfig";
    destination = "/share/notmuchconfig";
    text = ''
      [database]
      path=/home/wojtek/data/mail
      [user]
      name=Piotr Wojciech Dabrowski
      primary_email=piotr.dabrowski@posteo.de
      other_email=piotr.dabrowski@htw-berlin.de;dabrows@htw-berlin.de;piotr.dabrowski@posteo.net;
      [new]
      tags=inbox
      [search]
      [maildir]
    '';
  };  
in
{
  home.packages = [
    pkgs.notmuch
    notmuchconfig
  ];

  home.file.".notmuch-config".source = ${notmuchconfig}/share/notmuchconfig;
}
