{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-emoji

      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
    ];

    fontDir.enable = true;

    fontconfig = {
      antialias = true;
      hinting = {
        enable = true;
        autohint = true;
      };

      defaultFonts = {
        serif = [
          "Noto Serif CJK JP" # Japanese serif
          "Noto Serif"
        ];
        sansSerif = [
          "Noto Sans CJK JP" # Japanese sans
          "Noto Sans"
        ];
        monospace = [
          "DejaVu Sans Mono"
          "Noto Sans Mono CJK JP" #If code blocks with Japanese
        ];
      };
    };
  };
}
