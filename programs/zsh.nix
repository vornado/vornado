{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.zsh = {
    enable = true;

    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    autocd = true;
    dotDir = "${config.xdg.configHome}/zsh";

    history = {
      expireDuplicatesFirst = true;
      extended = true;
      ignoreSpace = true;
      path = "${config.xdg.cacheHome}/zsh/zsh_history";
    };

    plugins = [
      {
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
      {
        name = "fzf-git";
        src = pkgs.fzf-git-sh;
        file = "share/fzf-git-sh/fzf-git.sh";
      }
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
    ];

    initExtraFirst =
      /*
      bash
      */
      ''
        ZVM_INIT_MODE=sourcing
      '';

    initExtraBeforeCompInit =
      /*
      bash
      */
      ''
        # Enable colors
        autoload -U colors && colors

        # Change prompt
        prompt="%B%F{green}%n%f%b%F{grey}:%f%F{blue}[%f%F{red}%m%f%F{blue}]%f%F{grey}:%f%F{magenta}%~%f"''$'\n'"%B%F{yellow}''$%f%b "
      '';

    initExtra =
      /*
      bash
      */
      ''
        # Allow editing commands in text editor
        autoload -U edit-command-line
        zle -N edit-command-line
        bindkey '^x^e' edit-command-line

        # keybind to accept auto suggestions
        bindkey '^y' autosuggest-accept
        source <(fzf --zsh)

        export FZF_DEFAULT_COMMAND="${lib.getExe pkgs.fd} --hidden --strip-cwd-prefix --exclude .git"
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND="${lib.getExe pkgs.fd} --type=d --hidden --strip-cwd-prefix --exclude .git"

        # Use fd (https://github.com/sharkdp/fd) for listing path candidates.
        # - The first argument to the function ($1) is the base path to start traversal
        # - See the source code (completion.{bash,zsh}) for the details.
        _fzf_compgen_path() {
          ${lib.getExe pkgs.fd} --hidden --exclude .git . "$1"
        }

        # Use fd to generate the list for directory completion
        _fzf_compgen_dir() {
          ${lib.getExe pkgs.fd} --type=d --hidden --exclude .git . "$1"
        }


        export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
        export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

        # Advanced customization of fzf options via _fzf_comprun function
        # - The first argument to the function is the name of the command.
        # - You should make sure to pass the rest of the arguments to fzf.
        _fzf_comprun() {
          local command=$1
          shift

          case "$command" in
            cd)           ${lib.getExe pkgs.fzf} --preview '${lib.getExe pkgs.eza} --tree --color=always {} | head -200' "$@" ;;
            export|unset) ${lib.getExe pkgs.fzf} --preview "eval 'echo \$'{}" "$@" ;;
            ssh)          ${lib.getExe pkgs.fzf} --preview '${lib.getExe pkgs.dig} {}' "$@" ;;
            *)            ${lib.getExe pkgs.fzf} --preview "${lib.getExe pkgs.bat} -n --color=always --line-range :500 {}" "$@" ;;
          esac
        }

        zstyle ':fzf-tab:*' use-fzf-default-opts yes
        zstyle ':fzf-tab:complete:cd:*' fzf-preview '${lib.getExe pkgs.eza} -1 --color=always $realpath'
      '';

    sessionVariables = {
#     MANPAGER = "v +Man!";
#      EDITOR = "v";
    };
    shellAliases = {
      se = "sudo -e";
      ls = "${lib.getExe pkgs.eza} -lah --colour=always --group-directories-first";
      cp = "cp -riv";
      mv = "mv -iv";
      rm = "rm -vI";
      grep = "grep --color=auto";
      ssh = "TERM=xterm-256color ssh";
    };
  };
}

