{pkgs, inputs, ...}: {
  imports = [
    # ./neovim
    ./git
    ./tmux.nix
    ./zsh.nix
  ];

  home.packages = [
    inputs.neovim.packages.${pkgs.stdenv.hostPlatform.system}.nvim
  ];
}
