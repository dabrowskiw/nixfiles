{ config, lib, ... }:

{
  home.activation = {
    eduroamConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD mkdir -p /home/wojtek/.config/easyroam-certs/
      $DRY_RUN_CMD cp /home/wojtek/home-manager/secrets/eduroam/easyroam_client_cert.pem ${config.home.homeDirectory}/.config/easyroam-certs/easyroam_client_cert.pem 
      $DRY_RUN_CMD cp /home/wojtek/home-manager/secrets/eduroam/easyroam_client_key.pem ${config.home.homeDirectory}/.config/easyroam-certs/easyroam_client_key.pem
      $DRY_RUN_CMD cp /home/wojtek/home-manager/secrets/eduroam/easyroam_root_ca.pem ${config.home.homeDirectory}/.config/easyroam-certs/easyroam_root_ca.pem
    '';
  };
}

