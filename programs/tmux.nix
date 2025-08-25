{
  pkgs,
  config,
  ...
}: {
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 50000;
    terminal = "screen-256color";
    disableConfirmationPrompt = true;

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = resurrect;
        extraConfig =
          # tmux
          ''
            set -g @resurrect-capture-pane-contents 'on'
            set -g @resurrect-strategy-nvim 'session'
            set -g @resurrect-dir '${config.xdg.dataHome}/tmux/resurrect'
          '';
      }
      {
        plugin = continuum;
        extraConfig =
          # tmux
          ''
            set -g @continuum-restore 'on'
            set -g @continuum-save-interval '15' # minutes
          '';
      }
      {
        plugin = yank;
        extraConfig =
          # tmux
          ''
            set -g @yank_action "copy-pipe"
          '';
      }
    ];

    extraConfig = ''
      # Make sure neovim colorscheme works while using tmux
      set-option -g default-terminal "screen-256color"
      set -as terminal-features ',xterm*:RGB'
      set-option -sa terminal-overrides ',alacritty:RGB'

      # Enable full mouse support
      set -g mouse on

      # Key Bindings
      bind -r v split-window -h
      bind -r s split-window

      bind -r C-s choose-session

      unbind C-d
      bind C-D kill-window

      bind -r ^ last-window
      bind -r k select-pane -U
      bind -r j select-pane -D
      bind -r h select-pane -L
      bind -r l select-pane -R

      bind -r C-^ last-window
      bind -r C-k select-pane -U
      bind -r C-j select-pane -D
      bind -r C-h select-pane -L
      bind -r C-l select-pane -R

      bind -r o resize-pane -Z
      bind -r C-o resize-pane -Z
    '';
  };
}

