{ ... }:

{
  systemd = {
    mounts = [{
      type = "cifs";
      mountConfig = {
        Options = "noatime,credentials=/run/secrets/diskstationCreds";
      }; 
      what = "//192.168.178.92/Pictures";
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


