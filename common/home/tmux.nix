{...}: {
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    mouse = true;
    historyLimit = 5000;
    prefix = "C-b";
    sensibleOnTop = true;

    extraConfig = ''
      # Copy to system clipboard (X11)
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -selection clipboard"
      # for Wayland
      bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "wl-copy"

      # Optional: Copy with Enter key
      bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "xclip -selection clipboard"
    '';
  };
}
