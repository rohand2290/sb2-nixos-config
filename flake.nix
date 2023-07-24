{
  description = "A very basic flake";
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager.url = "github:nix-community/home-manager";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
		stylix.url = "github:danth/stylix";
		nur.url = "github:nix-community/NUR";
		nixvim.url = "github:nix-community/nixvim";
	};

  outputs = inputs@{ self, nur, stylix, home-manager, nixos-hardware, nixvim, nixpkgs, ... }: {
	nixosConfigurations = {
		surface = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				stylix.nixosModules.stylix {
					stylix.image = /home/rohand/Downloads/nord-rainbow-dark-nix.png;
				}	
				nur.nixosModules.nur
				./configuration.nix
				home-manager.nixosModules.home-manager {
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.users.rohand = { ... }: {
						imports = [
							nixvim.homeManagerModules.nixvim
							./home.nix

						];
					};
				}
			];
		};
	};


  };
}
