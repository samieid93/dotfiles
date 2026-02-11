{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home = {
    username = "samieid";
    homeDirectory = "/Users/samieid";
    stateVersion = "22.11";
    enableNixpkgsReleaseCheck = false;

    sessionVariables = {
      PATH = "$HOME/.local/bin:$PATH";
      NIX_PATH = "$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/$USER/channels";
      EDITOR = "nano";
    };

    # Only packages without dedicated programs.* modules
    packages = with pkgs; [
      # Existing
      zsh-autosuggestions
      coreutils-prefixed
      deno
      ffmpeg
      tldr
      yarn
      poetry
      codex
      ngrok

      # CLI tools (no home-manager modules)
      ripgrep      # Fast grep
      fd           # Fast find
      dust         # Disk usage
      bandwhich    # Network monitor
      jq           # JSON processor
      yq           # YAML processor
      httpie       # HTTP client
    ];
  };

  programs = {
    home-manager.enable = true;

    # === SHELL ===
    zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
      autosuggestion.enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "sudo" "colored-man-pages" ];
        # No theme - starship handles prompt
      };
      shellAliases = {
        # Existing
        sm = "deno run --allow-all https://jsr.io/@vessel/sm/0.0.8/main.ts";
        trp = "turbo run pretty lint check --no-daemon";

        # Better defaults using new tools
        ls = "eza --icons --group-directories-first";
        ll = "eza -la --icons --group-directories-first --git";
        la = "eza -a --icons --group-directories-first";
        lt = "eza --tree --level=2 --icons";
        cat = "bat --paging=never";
        grep = "rg";
        find = "fd";

        # Git shortcuts
        lg = "lazygit";
        gs = "git status";
        gd = "git diff";
        gco = "git checkout";
        gcb = "git checkout -b";

        # Utilities
        ports = "lsof -i -P -n | grep LISTEN";
        myip = "curl -s ifconfig.me";
        weather = "curl -s wttr.in";
      };
    };

    # === GIT ===
    git = {
      enable = true;
      userName = "sami";
      userEmail = "samieid93@gmail.com";
      delta = {
        enable = true;
        options = {
          navigate = true;
          side-by-side = true;
          line-numbers = true;
          syntax-theme = "Dracula";
        };
      };
      extraConfig = {
        init.defaultBranch = "main";
        pull.rebase = true;
        push.autoSetupRemote = true;
      };
    };

    # === NAVIGATION & SEARCH ===
    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultOptions = [ "--height 40%" "--border" ];
      # Ctrl+R = history, Ctrl+T = files, Alt+C = cd
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      # Use: z <partial-path> to jump anywhere
    };

    # === FILE VIEWING ===
    bat = {
      enable = true;
      config = {
        theme = "Dracula";
        style = "numbers,changes,header";
      };
    };

    eza = {
      enable = true;
      enableZshIntegration = true;
      icons = "auto";
      git = true;
    };

    # === GIT TUI ===
    lazygit = {
      enable = true;
      settings = {
        gui.theme = {
          lightTheme = false;
        };
      };
    };

    # === GITHUB CLI ===
    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
      };
    };

    # === SYSTEM MONITOR ===
    btop = {
      enable = true;
      settings = {
        color_theme = "dracula";
        theme_background = false;
      };
    };

    # === DIRENV (existing) ===
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
