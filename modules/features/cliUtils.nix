{ self, inputs, ... }: {
  flake.nixosModules.cliUtils = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      git tmux tree ripgrep
      fastfetch
      # tesseract
      # ffmpeg
      jq
    ];
  };
}
