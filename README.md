# ext - Helper Tool for Extracting Multiple Archive Types

`ext` is a simple bash script that helps you extract various archive types.

## Features

- Simple and easy to use
- Supported archive formats:
  - `.tar.bz2`
  - `.tar.gz`
  - `.bz2`
  - `.rar`
  - `.gz`
  - `.tar`
  - `.tbz2`
  - `.tgz`
  - `.zip`
  - `.Z`
  - `.7z`

## Usage

To use `ext`, simply run the script with the file you want to extract:

```sh
ext <file>
```

# Building from source

Follow these steps to build `ext` with Nix flakes:

## Prerequisites

- Install Nix and enable flakes by [enabling Nix flakes](https://nixos.wiki/wiki/Flakes).

## Step-by-Step Installation

1. Clone the Repository

```sh
git clone https://github.com/Dokkae6949/ext.git
cd ext
```

2. Build the Flake

```sh
nix build
```

3. Run the Script

```sh
./result/bin/ext <file>
```

# Using with Home Manager

To include this flake in your Home Manager configuration, follow these steps:

1. Add the Flake Input

Modify your flake.nix file to include your custom flake.

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    ext.url = "github:Dokkae6949/ext";
  }

  outputs = { self, nixpkgs, home-manager, ext }:
  let
    system = "x86_64-linux";
    username = "username";

    pkgs = inport nixpkgs { inherit system; };
  in {
    homeConfigurations."${username}" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      home.packages = [
        ext.packages."${system}".ext
      ];

      # or

      extraSpecialArgs = {
        inherit ext;
      };
    };
  };
}
```

2. Apply the Configuration:

Run the following commands to apply your updated Home Manager configuration.

```sh
nix flake update
home-manager switch --flake .
```

With this setup, ext will be available in your environment.

# License

This project is licensed under the MIT License.

# Contributing

Contributions are welcome! Please open an issue or submit a pull request.

# Acknowledgements

Thanks to the Nix and Home Manager communities for their amazing tools and support.
And special thanks to @Flokkq for the base script.
