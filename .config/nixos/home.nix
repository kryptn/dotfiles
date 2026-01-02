{
  config,
  pkgs,
  lib,
  ...
}:

let
  secrets = import ./secret.nix;
in
{
  imports = [
    ./starship.nix
    # ./speaker-keepalive.nix
    # /home/david/git/github.com/kryptn/nix/speaker-keepalive
  ];

  home.username = "david";
  home.homeDirectory = "/home/david";


  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them

    neofetch
    fastfetch
    hyfetch
    nnn # terminal file manager

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    just
    gh
    bat

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc # it is a calculator for the IPv4/v6 addresses

    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg
    oh-my-zsh
    direnv

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor
    nil
    nixfmt-rfc-style

    # productivity
    hugo # static site generator
    glow # markdown previewer in terminal

    btop # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb

    kubectl
    kubernetes-helm
    kustomize
    tenv
    xclip

    system76-keyboard-configurator

    # nodejs
    # pnpm
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "kryptn";
        email = secrets.gitEmail;
      };
      init.defaultBranch = "main";
      core.editor = "vim";
      push.autoSetupRemote = true;
      pull.rebase = false;
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      plus-style = "syntax #012800";
      minus-style = "syntax #340001";
      syntax-theme = "Monokai Extended";
      navigate = true;
    };
  };

  programs.awscli.enable = true;

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    theme = "monokai_pro";
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        bold = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold";
        };
        bold_italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold Italic";
        };
        italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Italic";
        };
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };

        size = 10;
        # draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;

    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    history = {
      ignoreSpace = true;
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "aws"
        "kubectl"
      ];
    };
    shellAliases = {
      kc = "kubectl";
      tf = "terraform";
      jn = "just /$HOME/.config/nixos/";
      config = "git --git-dir=\"$HOME/.cfg/\" --work-tree=\"$HOME\"";
    };
    initContent =
      let
        zshConfigEarlyInit = lib.mkOrder 500 ''

        '';
        zshConfig = lib.mkOrder 1000 ''
          function gsc() {
            rd="$HOME/git/github.com/$1"

            [ ! -d "$rd" ] && git clone "git@github.com:$1" "$rd"
            cd "$rd"
          }
        '';
        zshConfigAfter = lib.mkOrder 1400 ''
          export KUBECONFIG=""
          mkdir -p $HOME/.kube/
          touch $HOME/.kube/empty.yaml
          for file in $HOME/.kube/*.yaml
          do
            export KUBECONFIG=$KUBECONFIG:$file
          done
        '';
      in
      lib.mkMerge [
        zshConfigEarlyInit
        zshConfig
        zshConfigAfter
      ];
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your custom bashrc here
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      k = "kubectl";
      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
    };
  };

  # programs.ssh = {
  #   enable = true;
  #   addKeysToAgent = "yes";
  #   forwardAgent = true;

  #   matchBlocks = {
  #     github = {
  #       host = "*.github.com";
  #       hostname = "github.com";
  #       user = "git";
  #       identityFile = "~/.ssh/github_id_ed25519";

  #     };
  #   };


  # };

  services.mpris-proxy.enable = true;


  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";
}
