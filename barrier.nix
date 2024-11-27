{ ... }:

{
  services.barrier.client =  {
    enable = true;
    server = "nixos-worklaptop";
  };
}
