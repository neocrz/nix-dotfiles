# My Dotfiles

These are my personal dotfiles, managed with [Nix Flakes](https://nixos.wiki/wiki/Flakes), for configuring my NixOS and Nix-on-Droid environments.

## Structure

The repository is organized to separate configurations by host while sharing common modules.

```
├── README.md
├── common/           # Shared configurations for all hosts
│   ├── home/         # Home-Manager configurations
│   └── system/       # System-level configurations
├── flake.lock        # Automatically generated lock file for reproducibility
├── flake.nix         # Main entry point defining the flake's inputs and outputs
├── hosts/            # Host-specific configurations
│   ├── a5/           # Configuration for my Acer laptop (NixOS)
│   └── droid/        # Configuration for my Android device (Nix-on-Droid)
└── repl.nix          # Nix REPL environment for debugging
```

### Key Components

*   **`hosts/`**: Each subdirectory in `hosts` represents a unique machine. It contains a `default.nix` to define the system configuration and a `home.nix` for the user-level environment managed by [Home Manager](https://github.com/nix-community/home-manager).
*   **`common/`**: This directory contains modularized Nix files that are imported by the different hosts. This allows for sharing configurations like package lists, git settings, and services across multiple machines.

## Hosts

This flake manages the configuration for the following machines:

*   **`a5`**: An `x86_64-linux` machine running NixOS. This is my primary laptop.
*   **`droid`**: An `aarch64-linux` device set up with [Nix-on-Droid](https://github.com/nix-community/nix-on-droid), allowing me to have a Nix environment on my Android device.

## Managed Software

This configuration installs and manages a variety of command-line and graphical applications.

## Usage

To apply a configuration to a host, you can use the appropriate build command from within this repository.

### NixOS (`a5`)

To apply the configuration to the `a5` host, run:
```sh
sudo nixos-rebuild switch --flake .#a5
```

### Nix-on-Droid (`droid`)

For the `droid` device, the configuration can be activated using the `nix-on-droid` command:
```sh
nix-on-droid switch --flake .
```

### Flake exploration

My configuration includes a custom script, `my-nix-fast-repl`, designed for interactively exploring the entire flake from any managed host.

To use it, simply run the command in your terminal on either machine:
```
my-nix-fast-repl
```

This will launch a Nix REPL with the entire flake's evaluated outputs pre-loaded into a variable named flake. From there, you can navigate the configuration tree to inspect packages, options, and module settings for any host. (use tab for autocompletion)

**Examples**
```nix
nix-repl> flake.nixosConfigurations.a5.config.home-manager.users.eee.home.packages
nix-repl> flake.nixosConfigurations.a5.config.home-manager.users.eee.programs.git.userName
nix-repl> flake.nixosConfigurations.a5.config.environment.systemPackages
```
