{ pkgs ? import <nixpkgs> {
    overlays = [
      (import ./clojure-overlay.nix)
    ];
} }:

let
  nodejs = pkgs.nodejs-18_x;
  nodePackages = pkgs.nodePackages // {
    inherit (nodejs) nodejs;
    gulp = pkgs.nodePackages.gulp.override { inherit nodejs; };
    yarn = pkgs.nodePackages.yarn.override { inherit nodejs; };
    node-gyp = pkgs.nodePackages.node-gyp.override { inherit nodejs; };
  };
  macosDeps = if pkgs.stdenv.isDarwin then [
    pkgs.darwin.apple_sdk.frameworks.Foundation
    pkgs.darwin.apple_sdk.frameworks.AppKit
  ] else [];
in
pkgs.mkShell {
  buildInputs = [
      nodejs
      pkgs.zulu11
      pkgs.clojure
      nodePackages.gulp
      nodePackages.yarn
      nodePackages.node-gyp
      pkgs.python3
      pkgs.python3Packages.setuptools
      pkgs.python3Packages.distutils
    ] ++ macosDeps;
  shellHook = ''
    export npm_config_python=${pkgs.python3}/bin/python3
    export PATH=${pkgs.gcc}/bin:${pkgs.gnumake}/bin:$PATH

    function build() {
      yarn install && gulp build && yarn cljs:release-electron;
      yarn run release-electron

    }
  '';
}
