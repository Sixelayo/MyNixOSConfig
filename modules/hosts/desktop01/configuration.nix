{ self, inputs, ...} : {

  flake.nixosModules.desktop01Configuration = { pkgs, lib, ...} : {
    imports = [
      self.nixosModules.desktop01Hardware
      self.nixosModules.niri
      self.nixosModules.cliUtils
      self.nixosModules.neovim
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

  ##### Below is a paste of the default config with some deletion !
    
    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  
    networking.hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # services.displayManager.noctalia-greeter = {
    #   enable = true;
    #   settings.keyboard.layout = "fr";
    # };

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "fr";
      variant = "";
    };

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Enable networking
    networking.networkmanager.enable = true;
  
    # Set your time zone.
    time.timeZone = "Europe/Paris";
  
    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
  
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "fr_FR.UTF-8";
      LC_IDENTIFICATION = "fr_FR.UTF-8";
      LC_MEASUREMENT = "fr_FR.UTF-8";
      LC_MONETARY = "fr_FR.UTF-8";
      LC_NAME = "fr_FR.UTF-8";
      LC_NUMERIC = "fr_FR.UTF-8";
      LC_PAPER = "fr_FR.UTF-8";
      LC_TELEPHONE = "fr_FR.UTF-8";
      LC_TIME = "fr_FR.UTF-8";
    };
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
  
      fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
      ];
    };


    console.keyMap = "fr";
  
    # Enable sound with pipewire. (idk it was there originally)
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };


    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.ajust = {
      isNormalUser = true;
      description = "Alexis Just";
      extraGroups = [ "networkmanager" "wheel" ];
    };

    environment.systemPackages = with pkgs; [
	# main app
	mpv
        kdePackages.dolphin
	imv featherpad
	
	satty
	google-chrome 
	obsidian
	#anki-bin

	# coding
	alacritty
	# godot	blender	pixieditor vscode
	github-desktop
	gcc
	rustup

	#goofy pakcages
	figlet fortune pipes neo-cowsay cbonsai
	
	#terminal utils
	htop
        wl-clipboard #nescessary for pasting outside from neovim
	#tmux tmuxPlugins.resurrect #NOTE managed via programs !
	
	#cli tools
  	ripgrep
	stow
	ffmpeg
	yt-dlp
	jp2a
	gh
	qbittorrent

	#random utils
	tesseract
	poppler-utils #pdf utils
	
	#games
	# xivlauncher # yep nvm don't try this with a rtx980
	scrcpy
	ppsspp
	#osu-lazer
    ];

    xdg.mime.defaultApplications = {
      "video/*" = "mpv.desktop";
      "audio/*" = "mpv.desktop";
      "image/*" = "imv.desktop";
      "text/plain" = "featherpad.desktop";
  
      #"application/pdf" = "firefox.desktop";
    };
  

    # Enable the OpenSSH daemon.
    # Super restrictive, only for recovery from laptop in case of gpu faillure desktop doesn't have igpu
    services.openssh = {
      enable = true;
  
      openFirewall = false; #do not open port 22 by default
      settings = {
        PasswordAuthentication = false; #A password issn't enough, need a whitelisted SSH key
        KbdInteractiveAuthentication = false; # disable keyboard authentification
        PermitRootLogin = "no";
        AllowUsers = [ "ajust" ];
      };
    };
    users.users.ajust.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIErXhPRAT6ockyuTE/WVNIzgnOzy8YL9KChGChMvWbGD laptopCY"
    ];
    networking.firewall.enable = true;
    networking.firewall.extraCommands= ''
      iptables -A INPUT -s 192.168.1.0/24 -p tcp --dport 22 -j ACCEPT
    '';
    # networking.firewall.extraInputRules = ''
    #   ip saddr 192.168.1.0/24 tcp dport 22 accept
    # '';
  

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;
  
    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "25.11"; # Did you read the comment?

  };
}
