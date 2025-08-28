{ ... }:

{
  systemd = {
    mounts = [{
      type = "cifs";
      mountConfig = {
        Options = "noatime,uid=wojtek,gid=users,credentials=/run/secrets/diskstationCreds";
      }; 
      what = "//diskStation/Pictures";
      where = "/mnt/diskstation/Pictures";
    }];

    automounts = [{
      wantedBy = [ "multi-user.target" ];
      automountConfig = {
        TimeoutIdleSec = "600";
      };
      where = "/mnt/diskstation/Pictures";
    }];
  };
}


