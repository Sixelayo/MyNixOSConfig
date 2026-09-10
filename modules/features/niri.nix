# Note : some hard dependcy here, I know it's bad but I was too lazy to do things properly
# some shortcute assume that other programs are avaible system wide :
# - alacritty

{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };




  perSystem = { pkgs, lib, self', ... }: {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      settings = {
	spawn-at-startup =[
	  (lib.getExe self'.packages.myNoctalia)
	];
	binds = {
	# start other app
	  "Mod+D".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
	  "Mod+T".spawn-sh = "alacritty";

	# general
          "Mod+Q".close-window = _: { };
          "Mod+F".maximize-column = _: { };
          "Mod+G".fullscreen-window = _: { };
          "Mod+Shift+F".toggle-window-floating = _: { };
          "Mod+C".center-column = _: { };


	# window focus
          "Mod+Left".focus-column-left = _: { };	"Mod+H".focus-column-left = _: { };
          "Mod+Right".focus-column-right = _: { };	"Mod+L".focus-column-right = _: { };
          "Mod+Up".focus-window-up = _: { };		"Mod+K".focus-window-up = _: { };
          "Mod+Down".focus-window-down = _: { };	"Mod+J".focus-window-down = _: { };

          "Mod+Shift+Left".move-column-left = _: { };	"Mod+Shift+H".move-column-left = _: { };
          "Mod+Shift+Right".move-column-right = _: { };	"Mod+Shift+L".move-column-right = _: { };
          "Mod+Shift+Up".move-window-up = _: { };	"Mod+Shift+K".move-window-up = _: { };
          "Mod+Shift+Down".move-window-down = _: { };	"Mod+Shift+J".move-window-down = _: { };

	# workspace
	  "Mod+U".focus-workspace-down = _: { };
          "Mod+I".focus-workspace-up = _: { };

	  "Mod+1".focus-workspace = "w0";	"Mod+Shift+1".move-column-to-workspace = "w0";
          "Mod+2".focus-workspace = "w1";	"Mod+Shift+2".move-column-to-workspace = "w1";
          "Mod+3".focus-workspace = "w2";	"Mod+Shift+3".move-column-to-workspace = "w2";
          "Mod+4".focus-workspace = "w3";	"Mod+Shift+4".move-column-to-workspace = "w3";
          "Mod+5".focus-workspace = "w4";	"Mod+Shift+5".move-column-to-workspace = "w4";
          "Mod+6".focus-workspace = "w5";	"Mod+Shift+6".move-column-to-workspace = "w5";
          "Mod+7".focus-workspace = "w6";	"Mod+Shift+7".move-column-to-workspace = "w6";
          "Mod+8".focus-workspace = "w7";	"Mod+Shift+8".move-column-to-workspace = "w7";
          "Mod+9".focus-workspace = "w8";	"Mod+Shift+9".move-column-to-workspace = "w8";
          "Mod+0".focus-workspace = "w9";	"Mod+Shift+0".move-column-to-workspace = "w9";

	# resizing
	  "Mod+Ctrl+Left".set-column-width = "-5%";
          "Mod+Ctrl+Right".set-column-width = "+5%";
          "Mod+Ctrl+Down".set-window-height = "-5%";
          "Mod+Ctrl+Up".set-window-height = "+5%";

	};
      };
      # depreciated, default settings
      #extraSettings = [ { include = ./niri-config.kdl; } ];
    };


  };
}
