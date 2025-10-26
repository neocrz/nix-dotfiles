{
  pkgs,
  lib,
  isDesktop,
  ...
}:
# module is activated only if `isDesktop` is true
lib.mkIf isDesktop {
  programs.hyprland = {
    enable = true;
    withUWSM = false; # true - broke
    xwayland.enable = true; # Needed for X11 applications
  };

  # PipeWire
  services.pipewire.enable = true;
  security.rtkit.enable = true;

  # Enable the portal for screensharing, as per the NixOS Wiki.
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-hyprland];
  };

  # Hint Electron apps to use Wayland, as NixOS Wiki.
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    kitty
  ];

  # Unicode
  fonts.packages = with pkgs; [nerd-fonts.jetbrains-mono];

  home-manager.users."eee" = {
    imports = [../home/waybar.nix];
    home.packages = with pkgs; [
      # Hyprland Ecosystem
      hyprlock # Screen locker
      hypridle # Idle daemon
      hyprpicker # Color Picker
      hyprpolkitagent # Polkit authentication
      hyprsysteminfo # System Info GUI

      # Essential Wayland tools
      dunst # Notification daemon
      wlogout # Logout menu
      wl-clipboard # Clipboard tool
      grim # Screenshot tool
      slurp # For selecting a screen region with grim
      rofi # Laucher
    ];

    # -- THEME SUPPORT --

    home.pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 18;
    };

    gtk = {
      enable = true;
      theme = {
        package = pkgs.flat-remix-gtk;
        name = "Flat-Remix-GTK-Grey-Darkest";
      };
      iconTheme = {
        package = pkgs.adwaita-icon-theme;
        name = "Adwaita";
      };
      font = {
        name = "Sans";
        size = 11;
      };
    };

    # -- HYPRLAND CONFIGURATION --
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        # SUPER key
        "$mod" = "SUPER";

        # Startup commands
        exec-once = [
          "waybar"
          "syncthing"
        ];

        # Basic settings
        monitor = ",preferred,auto,1";
        input = {
          kb_layout = "br";
          follow_mouse = 1;
        };
        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;
          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";
        };
        decoration = {
          rounding = 10;
        };

        # Keybinds
        bind =
          [
            # --- Apps & Launchers ---
            "$mod, T, exec, ghostty"
            "$mod, E, exec, yazi"
            "$mod, O, exec, obsidian"
            "$mod, B, exec, floorp"
            "$mod, SPACE, exec, rofi -show drun"
            "$mod, R, exec, rofi -show run"

            # --- Window Management ---
            "$mod, Q, killactive,"
            "$mod, F, togglefloating,"
            "$mod, F11, fullscreen,"

            # --- Focus ---
            "$mod, left, movefocus, l"
            "$mod, right, movefocus, r"
            "$mod, up, movefocus, u"
            "$mod, down, movefocus, d"

            # --- Session Management ---
            "$mod, L, exec, hyprlock" # Lock the screen
            "$mod SHIFT, E, exec, wlogout" # Show the logout menu
            "$mod CTRL, Q, exit," # Exit Hyprland

            # --- Utilities ---
            "$mod SHIFT, S, exec, grim -g \"$(slurp)\"" # Screenshot a region
          ]
          ++ (
            # Workspaces
            # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
            builtins.concatLists (builtins.genList (
                i: let
                  ws = i + 1;
                in [
                  "$mod, code:1${toString i}, workspace, ${toString ws}"
                  "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
                ]
              )
              9)
          );
        # --- Mouse bindings ---
        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
        bindel = [
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ];
      };
    };

    services.hyprpaper = {
      enable = true;
      settings = {
        preload = ["/home/eee/ARQ/imgs/1751752844868753.webp"];
        wallpaper = [", /home/eee/ARQ/imgs/1751752844868753.webp"];
      };
    };
  };
}
