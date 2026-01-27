{ pkgs, ... }:

let
  singularity-with-cap = pkgs.stdenv.mkDerivation {
    name = "singularity-with-cap";
    buildInputs = [ pkgs.singularity pkgs.rsync ];
    buildCommand = ''
      # Copy only what's needed, ignoring permissions/ownership
      rsync -a --no-perms --no-owner ${pkgs.singularity}/ $out/
      
      # Create capability.json with correct permissions
      chmod 777 $out/etc/singularity/capability.json
      cat > $out/etc/singularity/capability.json <<EOF
      {
        "users": {
          "wojtek": [ "CAP_NET_ADMIN" ]
        }
      }
      EOF
      
      chmod 644 $out/etc/singularity/capability.json
    '';
  };
in {
  home.packages = [
    singularity-with-cap
  ];
}
