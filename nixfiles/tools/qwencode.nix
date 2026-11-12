{ pkgs, pkgs-unstable, lib, config, ... }:

let 
  qwencode_config = pkgs.writeTextFile {
    name = "qwencode_config.json";
    destination = "/share/qwencode_config.json";
    text = ''
{
  "privacy": {
    "usageStatisticsEnabled": false
  },
  "general": {
    "enableAutoUpdate": false
  },
  "telemetry": {
    "enabled": false,
    "logPrompts": false,
    "includeSensitiveSpanAttributes": false
  },
  "disableAllHooks": true,
  "mcpServers": {},
  "artifact": {
    "publisher": "local",
    "autoOpen": false
  }
}
    '';
  };

in
{
  home.packages = [
    qwencode_config
    pkgs.qwen-code
  ];

  home.file.".qwen/settings.json".source = "${qwencode_config}/share/qwencode_config.json";
}
