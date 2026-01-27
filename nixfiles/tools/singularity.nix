{ pkgs, lib, ... }: 

{
  home.packages = [
    pkgs.singularity
  ];
    environment.etc."singularity/capability.json".text = ''
    {
      "users": {
        "wojtek": [ "CAP_NET_ADMIN" ]
      },
      "groups": { }
    }
  '';
}

