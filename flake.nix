{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/25.11";

    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, ... }
    @inputs:
    inputs.utils.lib.eachSystem [ "x86_64-linux" ]
    (system: let

    pkgs = import nixpkgs {
      inherit system;

      config.allowUnfree = true;
    };
  in {
    devShells.default = pkgs.mkShell rec {
      name = "game-experimentation";

      packages = with pkgs; [
        # Development Tools
        llvmPackages_14.clang
        cmake
        cmakeCurses

        # Development time dependencies
        gtest

        # Build time and Run time dependencies
        spdlog
        abseil-cpp
      ];

    packages.default = pkgs.callPackage ./default.nix {};
  });
}
