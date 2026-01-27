{...}:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "piotr.dabrowski@htw-berlin.de";
        name = "Piotr Wojciech Dabrowski";
      };
    };
  };
  programs.delta = {
    enable = true;
    options = {
      "side-by-side" = true;
    };
    enableGitIntegration = true;
  };
}
