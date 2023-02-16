pkgs:
pkgs.writeShellScriptBin "gr" ''
  ${pkgs.gcc}/bin/gcc $1 && ./a.out
''
