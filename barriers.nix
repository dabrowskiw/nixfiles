{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.barrier
  ];
}
