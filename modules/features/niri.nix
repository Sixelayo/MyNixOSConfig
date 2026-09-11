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
	  "Mod+N".spawn-sh = "alacritty";

	# general
          "Mod+W".close-window = _: { };
          "Mod+F".maximize-column = _: { };
          "Mod+G".fullscreen-window = _: { };
          "Mod+Shift+F".toggle-window-floating = _: { };
          "Mod+C".center-column = _: { };


	# window focus
          "Mod+Left".focus-column-left = _: { };	"Mod+H".focus-column-left = _: { };
          "Mod+Right".focus-column-right = _: { };	"Mod+L".focus-column-right = _: { };
          "Mod+Up".focus-window-up = _: { };		"Mod+I".focus-window-up = _: { };
          "Mod+Down".focus-window-down = _: { };	"Mod+U".focus-window-down = _: { };

          "Mod+Shift+Left".move-column-left = _: { };	"Mod+Shift+H".move-column-left = _: { };
          "Mod+Shift+Right".move-column-right = _: { };	"Mod+Shift+L".move-column-right = _: { };
          "Mod+Shift+Up".move-window-up-or-to-workspace-up = _: { };
	  "Mod+Shift+K".move-window-up-or-to-workspace-up = _: { };
          "Mod+Shift+Down".move-window-down-or-to-workspace-down = _: { };
	  "Mod+Shift+J".move-window-down-or-to-workspace-down = _: { };

	# workspace
	  "Mod+O".toggle-overview = _: { };
	  "Mod+J".focus-workspace-down = _: { };
          "Mod+K".focus-workspace-up = _: { };
	  "Mod+Tab".focus-workspace-previous = _: { };

	  "Mod+A".focus-workspace = 1;	"Mod+Shift+A".move-column-to-workspace = 1;
	  "Mod+Z".focus-workspace = 2;	"Mod+Shift+Z".move-column-to-workspace = 2;
	  "Mod+E".focus-workspace = 3;	"Mod+Shift+E".move-column-to-workspace = 3;
	  "Mod+R".focus-workspace = 4;	"Mod+Shift+R".move-column-to-workspace = 4;
          "Mod+T".focus-workspace = 5;	"Mod+Shift+T".move-column-to-workspace = 5;
          "Mod+Y".focus-workspace = 6;	"Mod+Shift+Y".move-column-to-workspace = 6;


	# resizing
	  "Mod+Ctrl+Left".set-column-width = "-5%";	"Mod+Ctrl+H".set-column-width = "-5%";
          "Mod+Ctrl+Right".set-column-width = "+5%";	"Mod+Ctrl+L".set-column-width = "+5%";
          "Mod+Ctrl+Down".set-window-height = "-5%";	"Mod+Ctrl+J".set-window-height = "-5%";
          "Mod+Ctrl+Up".set-window-height = "+5%";	"Mod+Ctrl+K".set-window-height = "+5%";

	};
      };
      # depreciated, default settings
      #extraSettings = [ { include = ./niri-config.kdl; } ];
    };


  };
}
