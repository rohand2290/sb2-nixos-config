{ lib, config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "rohand";
  home.homeDirectory = "/home/rohand";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
	hyprpaper
	neofetch
	python3
	bat
	bemenu
	sway-contrib.grimshot
	texlive.combined.scheme-full
	pipes-rs
	libgen-cli
	nodejs
	neovide
	wlr-randr

  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/rohand/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  	EDITOR = "nvim";
  };
	programs.wezterm = {
		enable = true;
	};

	programs.nixvim = {
		enable = true;
		plugins = {
			lualine = {
				enable = true;
			};
			nvim-tree = {
				enable = true;
			};
			nvim-autopairs = {
				enable = true;
			};
			treesitter = {
				enable = true;
			};
			vimtex = {
				enable = true;
			};
		};
		colorschemes.base16 = {
			enable = true;
			colorscheme = "nord";
		};
	};
	programs.alacritty = {
		enable = true;
	};
	programs.zathura = {
		enable = true;
	};
	programs.i3status = {
		enable = true;
	};
	programs.qutebrowser = {
		enable = true;
		extraConfig = ''
c.colors.webpage.preferred_color_scheme = "dark"
c.completion.web_history.max_items = 0
		'';
	};

	programs.zsh = {
		enable = true;
		enableSyntaxHighlighting = true;
		loginExtra = "sway";
		shellAliases = {
			update = "sudo nixos-rebuild switch --flake /etc/nixos#surface --impure";
		};
		oh-my-zsh = {
			enable = true;
			plugins = ["git" "vi-mode"];
			theme = "minimal";
		};
	};
	programs.lf = {
		enable = true;
	};
	wayland.windowManager.sway = {
		enable = true;
		config = rec {
			modifier = "Mod4";
			terminal = "alacritty";
			window.titlebar = false;
			gaps = {
				inner = 12;
				outer = 5;
				smartGaps = false;
			};
			bars = [
				({
					mode = "dock";
					hiddenState = "hide";
					position = "top";
					workspaceButtons = true;
					workspaceNumbers = false;
					statusCommand = "${pkgs.i3status}/bin/i3status";
					trayOutput = "primary";
				 } // config.lib.stylix.sway.bar)
			];
			input = {
				"*" = {
					xkb_options = "caps:escape";
				};
			};
			keybindings = 
				let
					modifier = config.wayland.windowManager.sway.config.modifier;
				in lib.mkOptionDefault {
					"${modifier}+d" = "exec bemenu-run";
					"${modifier}+n" = ''exec find /etc/nixos \( ! -regex '.*/\..*' \) -type f | bemenu -p "Edit which config file?" | xargs alacritty -e sudoedit'';
					"${modifier}+q" = "kill";
					"${modifier}+j" = "focus down";
					"${modifier}+k" = "focus up";
					"${modifier}+h" = "focus left";
					"${modifier}+l" = "focus right";
					"${modifier}+w" = "exec qutebrowser";
					"Print" = "exec grimshot save area";

				};
		};
	};
	


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
