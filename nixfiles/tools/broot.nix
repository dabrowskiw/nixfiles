{ pkgs, ... }:

{
  programs.broot = {
    enable = true;
    settings = {
      verbs = [
        {
          invocation = "a";
          execution = "echo {file}";
          leave_broot = true;
        }
        {
          key = "ctrl-enter";
          external = "cd {file}";
          leave_broot = true;
        }
      ];
      special_paths = {
        "/home/wojtek/pCloud" = {
          list = "never";
          sum = "never";
          show = "never";
        };
        "/home/wojtek/pCloudDrive" = {
          list = "never";
          sum = "never";
          show = "never";
        };
        "/home/wojtek/onedrive" = {
          list = "never";
          sum = "never";
          show = "never";
        };
        "/home/wojtek/oneDrive" = {
          list = "never";
          sum = "never";
          show = "never";
        };
        "/mnt/diskstation" = {
          list = "never";
          sum = "never";
          show = "never";
        };
      };
    }; 
    enableFishIntegration = true;
  };
}

