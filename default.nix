pkgs:
pkgs.writeShellScriptBin "md" ''
  $EDITOR $1.md
''
