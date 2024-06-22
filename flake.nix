{
  description = "Helper tool for extracting multiple archive types";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { 
          inherit system;
          config.allowUnfree = true;
        };
        ext-name = "ext";
        ext-buildInputs = with pkgs; [ 
          gnutar
          bzip2
          rar # unfree
          gzip
          unzip
          xz
          p7zip
        ];
        ext-src = builtins.readFile ./ext.sh;
        ext-script = pkgs.writeScriptBin ext-name ext-src;
      in rec {
        defaultPackage = packages.ext-script;
        packages.ext = pkgs.symlinkJoin {
          name = ext-name;
          paths = [ ext-script ] ++ ext-buildInputs;
          buildInputs = [ pkgs.makeWrapper ];
          postBuild = ''
            wrapProgram $out/bin/${ext-name} --prefix PATH : ${pkgs.lib.makeBinPath ext-buildInputs}
            patchShebangs $out/bin/${ext-name}
          '';
        };
      }
    );
}
