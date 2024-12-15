{ pkgs, ... }:

{
  home.packages = [
    pkgs.xournalpp
  ]; 

  xdg = {
    desktopEntries.xournalpp = {
      name = "XournalPP";
      exec = "xournalpp";
      terminal = false;
      mimeType = [ "application/pdf" ];
    };
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "xournalpp.desktop";
        "application/octet-stream" = "xournalpp.desktop";
      };
    }; 
  };
}
