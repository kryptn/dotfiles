{config, ...}: {
  nixpkgs.config.allowBroken = true;
  boot = {
    blacklistedKernelModules = [ "r8169" ];
    extraModulePackages = with config.boot.kernelPackages; [
      r8125
    ];
    kernelModules = [ "r8125" ];
  };
}