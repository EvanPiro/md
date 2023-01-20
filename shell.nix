pkgs:
pkgs.mkShell {
  buildInputs = [
    pkgs.postgresql
  ];
}
