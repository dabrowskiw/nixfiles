{ mysecrets, ... }:

{
  sops = {
    validateSopsFiles = false;
    age = {
      sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
      keyFile = "/var/lib/sops-nix/keys.txt";
      generateKey = true;
    };
    secrets.diskstationCreds = {
      sopsFile = "${mysecrets}/secrets/diskstation.creds";
      format = "binary";
    };
  };
}
