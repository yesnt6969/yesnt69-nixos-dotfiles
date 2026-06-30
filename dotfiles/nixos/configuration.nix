# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{  config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Novideo, Steam ve diğerleri için
  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 3;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # IF novideo wont work uncomment these 2 line under this line
  # boot.blacklistedKernelModules = [ "nouveau" ];
  # services.xserver.videoDrivers = [ "amdgpu" ];

  # OpenGL stuff
  hardware.graphics = {
    enable = true;
    enable32Bit = true; 
  };


  # WARNGING THIS SECTION DIRECTLY COPIED FROM AI CHAT. 
  # IF YOU HAVE ALLERGY TO VIBE CODING REMOVE THIS SECTION. 
  # -IM JUST A REGULAR EVERYDAY NORMAL MOTHERF*KER-

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  
  # Cihaz adı bölümü / Hostname section
  networking.hostName = "nixus"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Istanbul";
  time.hardwareClockInLocalTime = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "tr_TR.UTF-8";
  console = {
    font = "ter-v24n";
    useXkbConfig = true; # use xkb.options in tty.
  };
  

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Sway buraya gelecek

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
      extraOptions = [
        "--unsupported-gpu"
    ];
  };

  # After novideo driver issues, you cant see cursor uncomment 1 line under this line 
  # environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";


  # KDE buraya gelecek
  services.desktopManager.plasma6.enable = true;


  # XDG portal stuff
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.kdePackages.xdg-desktop-portal-kde
    ];
    config.common.default = "sway";
  };


  # SDDM buraya gelecek
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };



  # KDE Connect buraya gelecek

  programs.kdeconnect.enable = true;
  services.dbus.enable = true;



  # Configure keymap in X11
  services.xserver.xkb.layout = "tr";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;    
    wireplumber.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.burak = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
  };

  # 4 Fish

  programs.fish.enable = true;

  # Fayurfox

  programs.firefox.enable = true;



  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    git
    wget
    fastfetch
    telegram-desktop
    alacritty # 4 Terminal app
    waybar # Sway essentials start here
    wofi
    dunst
    libnotify
    swaybg
    gtklock # swaylock alternatifi
    swayidle
    swayr
    fuzzel
    grim
    slurp
    wl-clipboard 
    kdePackages.kio # KDE Infrastructure start here
    kdePackages.kio-extras
    kdePackages.kio-fuse
    kdePackages.qt6ct 
    kdePackages.breeze # Theme Infrastructure start here
    kdePackages.breeze-icons 
    kdePackages.qtmultimedia
    networkmanagerapplet # Other system integration start here
    kdePackages.plasma-nm
    kdePackages.plasma-pa 
    gnome-themes-extra # Adwaita-dark theme infrastructure start here
    gsettings-desktop-schemas
    nwg-panel
    brightnessctl
    pavucontrol
    bluez
    bluez-tools
  ];

  # Dunst Ayarları / Dunst Settings
  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "Sans 11";
        origin = "top-right";
        offset = "(20, 20)";
        width = 350;
        height = "(150, 150)";
        frame_width = 1;
        frame_color = "#2d5a1b";
        corner_radius = 16;
        padding = 16;
        horizontal_padding = 16;
        icon_position = "left";
        max_icon_size = 48;
      };
      urgency_low = {
        background = "#0d1208d9";
        foreground = "#ffffff";
        frame_color = "#2d5a1b";
        timeout = 5;
      };
      urgency_normal = {
        background = "#0d1208d9";
        foreground = "#ffffff";
        frame_color = "#2d5a1b";
        timeout = 7;
      };
    };
  };


  # GTKLock PAM setting
  security.pam.services.gtklock = {};


  # Bluetooth Servisi

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;



  qt = {
    enable = true;
    platformTheme = "kde";
    style = "breeze";
  };


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

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}

