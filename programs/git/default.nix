{
  pkgs,
  lib,
  ...
}: {
  home.shellAliases.g = "git";

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "vornado";
        email = "andrewcarlson.engr@gmail.com";
      };

      alias = let
        toolbelt = pkgs.git-toolbelt;
        absorb = pkgs.git-absorb;
      in {
        absorb = "!${lib.getExe absorb}";
        ac = "!git add -A && git commit";
        alias = "config --get-regexp ^alias";
        br = "branch --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) [%(authorname)]' --sort=-committerdate";
        ca = "commit --amend";
        cane = "commit --amend --no-edit";
        ci = "commit";
        cm = "commit --message";
        co = "checkout";
        cob = "checkout -b";
        del = "branch -D";
        bd = "!git diff --name-only --relative --diff-filter=d | xargs bat --diff";
        dump = "cat-file -p";
        last = "log -1 HEAD --stat --pretty=format:\"%C(magenta)%h%Creset -%C(red)%d%Creset %s %C(dim green)(%cr) [%an]\"";
        lg = "log --pretty=format:\"%C(magenta)%h%Creset -%C(red)%d%Creset %s %C(dim green)(%cr) [%an]\" --abbrev-commit -30";
        pl = "pull";
        ps = "push";
        res = "reset --hard";
        restore = "checkout HEAD --";
        st = "status -sb";
        type = "cat-file -t";
        undo = "reset HEAD~1 --mixed";
        wt = "worktree";

        # git-toolbelt
        cleanup = "!${toolbelt}/bin/git-cleanup";
        current-branch = "!${toolbelt}/bin/git-current-branch";
        main-branch = "!${toolbelt}/bin/git-main-branch";
        fixup = "!${toolbelt}/bin/git-fixup";
        fixup-with = "!${toolbelt}/bin/git-fixup-with";
        active-branches = "!${toolbelt}/bin/git-active-branches";
        diff-since = "!${toolbelt}/bin/git-diff-since";
        local-branches = "!${toolbelt}/bin/git-local-branches";
        local-commits = "!${toolbelt}/bin/git-local-commits";
        merged = "!${toolbelt}/bin/git-merged ";
        unmerged = "!${toolbelt}/bin/git-unmerged ";
        merge-status = "!${toolbelt}/bin/git-merge-status";
        branches-containing = "!${toolbelt}/bin/git-branches-containing";
        recent-branches = "!${toolbelt}/bin/git-recent-branches";
        remote-branches = "!${toolbelt}/bin/git-remote-branches";
        remote-tracking-branch = "!${toolbelt}/bin/git-remote-tracking-branch";
        repo = "!${toolbelt}/bin/git-repo";
        root = "!${toolbelt}/bin/git-root";
        initial-commit = "!${toolbelt}/bin/git-initial-commit";
        sha = "!${toolbelt}/bin/git-sha";
        stage-all = "!${toolbelt}/bin/git-stage-all";
        unstage-all = "!${toolbelt}/bin/git-unstage-all";
        update-all = "!${toolbelt}/bin/git-update-all";
        workon = "!${toolbelt}/bin/git-workon";
        modified = "!${toolbelt}/bin/git-modified";
        modified-since = "!${toolbelt}/bin/git-modified-since";
        separator = "!${toolbelt}/bin/git-separator";
        spinoff = "!${toolbelt}/bin/git-spinoff";
        wip = "!${toolbelt}/bin/git-wip";
        committer-info = "!${toolbelt}/bin/git-committer-info";
        drop-local-changes = "!${toolbelt}/bin/git-drop-local-changes";
        stash-everything = "!${toolbelt}/bin/git-stash-everything";
        push-current = "!${toolbelt}/bin/git-push-current";
        undo-commit = "!${toolbelt}/bin/git-undo-commit";
        undo-merge = "!${toolbelt}/bin/git-undo-merge";
        is-repo = "!${toolbelt}/bin/git-is-repo";
        is-headless = "!${toolbelt}/bin/git-is-headless";
        has-local-changes = "!${toolbelt}/bin/git-has-local-changes ";
        is-clean = "!${toolbelt}/bin/git-is-clean ";
        is-dirty = "!${toolbelt}/bin/git-is-dirty";
        has-local-commits = "!${toolbelt}/bin/git-has-local-commits";
        contains = "!${toolbelt}/bin/git-contains ";
        is-ancestor = "!${toolbelt}/bin/git is-ancestor";
        local-branch-exists = "!${toolbelt}/bin/git-local-branch-exists";
        remote-branch-exists = "!${toolbelt}/bin/git-remote-branch-exists";
        tag-exists = "!${toolbelt}/bin/git-tag-exists";
        skip = "!${toolbelt}/bin/git-skip ";
        unskip = "!${toolbelt}/bin/git-unskip ";
        show-skipped = "!${toolbelt}/bin/git-show-skipped";
        commit-to = "!${toolbelt}/bin/git-commit-to";
        cherry-pick-to = "!${toolbelt}/bin/git-cherry-pick-to";
        delouse = "!${toolbelt}/bin/git-delouse";
        shatter-by-file = "!${toolbelt}/bin/git-shatter-by-file";
        cleave = "!${toolbelt}/bin/git-cleave";
      };

      core = {
        editor = "v";
      };

      init = {
        defaultBranch = "master";
      };

      push = {
        autoSetupRemote = true;
      };

      merge = {
        tool = "v";
      };
      mergetool = {
        keepBackup = true;
        prompt = false;
        v = {
          cmd = "v -c DiffviewOpen";
        };
      };

      color = {
        ui = true;

        branch = {
          current = "yellow reverse";
          local = "yellow";
          remote = "green";
        };

        diff = {
          meta = "yellow bold";
          frag = "magenta bold";
          old = "red bold";
          new = "green bold";
        };

        status = {
          added = "yellow";
          changed = "green";
          untracked = "red";
        };
      };
    };

    ignores = [
      ".luarc.json"
    ];
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      line-numbers = true;
      side-by-side = true;
    };
  };
}

