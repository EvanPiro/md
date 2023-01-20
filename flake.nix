{
  description = "Dev shell sandbox";
  inputs = {
    nixpkgs.url = "github:EvanPiro/nixpkgs";
  };
  outputs = {
    self,
    nixpkgs,
  }: let
    # Add supported systems
    systems = ["x86_64-darwin" "x86_64-linux"];
    mkDevShell = import ./shell.nix;
  in
    nixpkgs.lib.pipe systems [
      (builtins.map (system: let
        pkgs = nixpkgs.legacyPackages.${system}.pkgs;
      in {
        # Add set conforming to flake schema here:
        devShells.${system}.default = mkDevShell pkgs;
        formatter.${system} = pkgs.alejandra;
      }))

      (builtins.foldl' nixpkgs.lib.recursiveUpdate {})
    ];
}
