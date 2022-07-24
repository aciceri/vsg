{
  inputs = {
    dream2nix.url = github:nix-community/dream2nix;
    src = {
      url = "https://files.pythonhosted.org/packages/5b/ad/29e9a4acb3986cfa8af548f97b15ac403481b387245d7306b43be6affd6f/vsg-3.11.0.tar.gz";
      flake = false;
    };
  };

  outputs = {
    self,
    dream2nix,
    src,
  } @ inp: (dream2nix.lib.makeFlakeOutputs {
    systems = ["x86_64-linux"];
    config.projectRoot = ./.;
    source = src;
    settings = [
      {
        # optionally define python version
        subsystemInfo.pythonAttr = "python38";
        # # optionally define extra setup requirements;
        subsystemInfo.extraSetupDeps = ["cython > 0.29"];
      }
    ];
  }) // {
    apps.x86_64-linux.default = {
      type = "app";
      program = "${self.packages.x86_64-linux.main}/bin/vsg";
    };
  };
}
