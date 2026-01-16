{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      font-family = "JetBrainsMono Nerd Font";
      font-size = 10;
      theme = "Monokai Vivid";

      copy-on-select = "clipboard";

      keybind = [
        "ctrl+v=paste_from_clipboard"
        "ctrl+c=copy_to_clipboard"
      ];

      window-padding-x = 4;
      window-padding-y = 4;

      scrollback-limit = 10000;
    };
  };
}
