# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  inputs,
  ...
}:

let
  secrets = import ./secret.nix;
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    ./nvidia.nix
    ./realtek.nix
    # ./speaker-keepalive.nix
    # ./hyprland.nix
  ];


  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  services.solaar.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelModules = [
    "wireguard"
  ];
  # networking.wg-quick.interfaces.wg0.configFile = "/home/david/Downloads/mullvad_wireguard_linux_all_all/se-sto-wg-006.conf";
  networking.wg-quick.interfaces.wg0 = {
    configFile = "/etc/nixos/wg0.conf";
    autostart = false;
  };
  services.resolved.enable = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        AutoEnable = true;
        ControllerMode = "bredr";
      };
    };
  };

  services.blueman.enable = true;

  # Set your time zone.
  time.timeZone = "America/Denver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.jetbrains-mono
  ];

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  # services.pulseaudio.enable = false;
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

  services.pipewire.wireplumber.extraConfig."10-bluez" = {
    "monitor.bluez.properties" = {
      "bluez5.enable-sbc-xq" = true;
      "bluez5.enable-msbc" = true;
      "bluez5.enable-hw-volume" = true;
      "bluez5.roles" = [
        "hsp_hs"
        "hsp_ag"
        "hfp_hf"
        "hfp_ag"
      ];
    };
  };

  # Disable node suspend on NVIDIA graphics
  services.pipewire.wireplumber.extraConfig."99-disable-suspend"."monitor.alsa.rules" = [
    {
      matches = [ { "node.name" = "alsa_output.pci-0000_7a_00.6.iec958-stereo"; } ];
      actions.update-props = {
        "session.suspend-timeout-seconds" = 0;
        "node.always-process" = true;
        "dither.method" = "wannamaker3";
        "dither.noise" = 1;
      };
    }
  ];

  # avahi required for service discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      userServices = true;
      domain = true;
    };
  };

  services.pipewire = {
    # opens UDP ports 6001-6002
    raopOpenFirewall = true;

    # extraConfig.pipewire = {
    #   "10-airplay" = {
    #     "context.modules" = [
    #       {
    #         name = "libpipewire-module-raop-discover";

    #         # increase the buffer size if you get dropouts/glitches
    #         # args = {
    #         #   "raop.latency.ms" = 500;
    #         # };
    #       }
    #     ];
    #   };
    # };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.david = {
    isNormalUser = true;
    description = "david";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    packages = with pkgs; [
      kdePackages.kate
      #  thunderbird
    ];
    shell = pkgs.zsh;
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = with pkgs; [
    lshw
    vscode.fhs
    vim
    wget
    curl
    direnv
    fastfetch
    starship
    zsh
    alacritty
    lunarvim
    gcc
    pkg-config
    wayland
    tailscale
    # satisfactorymodmanager
    dualsensectl
    yafc-ce
  ];

  programs.zsh = {
    enable = true;
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    # flake = "/home/user/my-nixos-config";
    flake = "/home/david/.config/nixos/";
  };

  # programs.starship = {
  #   enable = true;
  #   # enableBashIntegration = true;
  #   # enableNushellIntegration = true;
  #   # enableZshIntegration = true;
  #   settings = {
  #     "$schema" = "https://starship.rs/config-schema.json";
  #   };
  # };

  programs.direnv.enableZshIntegration = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  services.flatpak = {
    enable = true;
    update.auto = {
      enable = true;
      onCalendar = "hourly";
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  services.tailscale = {
    enable = true;
    # extraSetFlags = [
    #   "--ssh"
    #   "--accept-routes"
    #   "--accept-dns"
    # ];
  };

  systemd.services.tailscale-autoconnect = {
    description = "Automatic connection to Tailscale";

    # make sure tailscale is running before trying to connect to tailscale
    after = [
      "network-pre.target"
      "tailscale.service"
    ];
    wants = [
      "network-pre.target"
      "tailscale.service"
    ];
    wantedBy = [ "multi-user.target" ];

    # set this service as a oneshot job
    serviceConfig.Type = "oneshot";

    # have the job run this shell script
    script = with pkgs; ''
      # wait for tailscaled to settle
      sleep 2

      # check if we are already authenticated to tailscale
      status="$(${tailscale}/bin/tailscale status -json | ${jq}/bin/jq -r .BackendState)"
      if [ $status = "Running" ]; then # if so, then do nothing
        ${tailscale}/bin/tailscale up --ssh --accept-routes --accept-dns
        exit 0
      fi

      # otherwise authenticate with tailscale
      ${tailscale}/bin/tailscale up
    '';
  };

  virtualisation.docker = {
    enable = true;
  };

  security = {
    # If enabled, pam_wallet will attempt to automatically unlock the user’s default KDE wallet upon login.
    # If the user has no wallet named “kdewallet”, or the login password does not match their wallet password,
    # KDE will prompt separately after login.
    pam = {
      services = {
        david = {
          kwallet = {
            enable = true;
            package = pkgs.kdePackages.kwallet-pam;
          };
        };
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  # fileSystems."/mnt/hippocampus" = {
  #   device = "${secrets.nasIp}:/volume1";
  #   fsType = "nfs";
  # };

  # boot.supportedFilesystems = [ "nfs" ];

}
