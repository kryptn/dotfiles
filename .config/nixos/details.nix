{ pkgs, lib, ... }:

with lib;
with builtins;

let

in
{
  home.username = "david";
  home.homeDirectory = "/home/david";
}