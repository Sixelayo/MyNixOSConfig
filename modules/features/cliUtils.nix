{ self, inputs, ... }: {
  flake.nixosModules.cliUtils = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      git tmux tree ripgrep
      # tesseract
      # ffmpeg
      jq
    ];
  };
}
