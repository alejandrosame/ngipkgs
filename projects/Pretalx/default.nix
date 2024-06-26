{
  pkgs,
  lib,
  sources,
} @ args: {
  packages = {
    inherit (pkgs) pretalxFull;
  };

  nixos = {
    modules.services.ngi-pretalx = ./service.nix;
    tests.pretalx = import ./test args;
    configurations = {
      base = {
        path = ./config/base.nix;
        description = ''
          Basic configuration for Pretalx, incl. secret management with SOPS, excl. database settings.
        '';
      };
      postgresql = {
        path = ./config/postgresql.nix;
        description = ''
          Supplementary to `base.nix`, adds database configuration for PostgreSQL.
        '';
      };
      mysql = {
        path = ./config/mysql.nix;
        description = ''
          Supplementary to `base.nix`, adds database configuration for MySQL.
        '';
      };
    };
  };
}
