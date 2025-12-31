{ lib, pkgs, config, stdenv, ... }:

let
  fs = lib.fileset;
  audioFile = ./preventStandbyHum.wav;
in
fs.trace audioFile
stdenv.mkDerivation
{
  name = "speaker-keepalive-job";
  
  src = fs.toSource {
    root = ./.;
    fileset = audioFile;
  };
  installPhase = ''
    mkdir $out
    cp -v ${audioFile} $out
  '';
}