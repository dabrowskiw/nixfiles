{...}:

{
  programs.git = {
    enable = true;
    userEmail = "piotr.dabrowski@htw-berlin.de";
    userName = "Piotr Wojciech Dabrowski";
    delta = {
      enable = true;
      options = {
        "side-by-side" = true;
      };
    };
  };
}
