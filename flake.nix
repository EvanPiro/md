{
  description = "An assortment of tools";
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
        mypkgs = import ./. pkgs;
      in {
        # apps.${system}.md = {
        #  type = "app";
        #  program = "${md}/bin/md";
        # };
        packages.${system} = mypkgs;
        devShells.${system}.default = mkDevShell pkgs;
        formatter.${system} = pkgs.alejandra;
      }))

      (builtins.foldl' nixpkgs.lib.recursiveUpdate {})
    ];
}
