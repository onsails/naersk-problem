{

  inputs = {
    naersk.url = "github:nmattia/naersk/master";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils, naersk }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        naersk-lib = pkgs.callPackage naersk { };
      in {

        defaultPackage = naersk-lib.buildPackage {
          root = ./.;
        };
        
        # If you have a default binary in your project, add path to it here
        # defaultApp = {
        #   type = "app";
        #   program = "${self.defaultPackage."${system}"}/bin/%BINARY_PATH_HERE%";
        # };
      });
}
