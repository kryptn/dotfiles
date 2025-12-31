{
  config,
  pkgs,
  lib,
  ...

}:
let
  speaker-keepalive = pkgs.callPackage ./speaker-keepalive-pkg.nix {};
  # keepalive-app = pkgs.writeShellApplication {
  #   name = "keep-speakers-alive";

  #   runtimeInputs = [
  #     puluseaudio
  #     libnotify
  #   ];

  #   text = ''
  #     paplay --volume=1 ${speaker-keepalive}/preventStandbyHum.wav
  #     send-message "Speaker keepalive job executed successfully"
  #   '';
  # };
in
{
  
  
  environment.systemPackages = [
    speaker-keepalive
  ];

  systemd.timers.speaker-keepalive-timer = {
    enable = true;
    description = "Keep Speakers Alive";

    # run this job every 10 minutes
    timerConfig.OnBootSec = "5min";
    timerConfig.OnUnitActiveSec = "5min";

    # make sure this job is enabled
    wantedBy = [ "timers.target" ];
    wants = [ "speaker-keepalive.service" ];
  };

  

  systemd.services.speaker-keepalive = {
    enable = true;
    description = "Keep Speakers Alive";
    
    wantedBy = [
      "speaker-keepalive-timer.timer"
      "multi-user.target"
    ];
    path = with pkgs; [ pipewire  ];
    
    

    # set this service as a oneshot job
    serviceConfig.Type = "oneshot";

    # have the job run this shell script
    # script = ''
    #   pw-play ${speaker-keepalive}/preventStandbyHum.wav
    #   ${pkgs.nix}/bin/nix-shell -p pipewire --run "pw-play ${speaker-keepalive}/preventStandbyHum.wav"
    #   ${pkgs.nix}/bin/nix-shell -p lib-notify -run send-message "Speaker keepalive job executed successfully"
    # '';
    script = ''
      pw-play ${speaker-keepalive}/preventStandbyHum.wav
    '';
  };

}
