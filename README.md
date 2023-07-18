# sb2-nixos-config
My NixOS config files for my Surface Book 2, managed by 
[`home-manager`](https://github.com/nix-community/home-manager)

This definitely needs some cleaning up, but it's a good first start for at least a frame of reference. It uses some pretty vanilla configs, nothing crazy going on like impermanence and ZFS, just regular good-old ext4 partitions.

Inspired by Luke Smith's [LARBS](https://github.com/LukeSmithxyz/LARBS), which was my first foray in the world of WM's, I wanted to recreate a similar config on NixOS. It runs many of the same minimalist programs, like Zathura, but just uses Wayland and Sway, as well as some Wayland replacements for minimalist programs, like `bemenu` to replace `dmenu`.

-   [Installation](#installation)
-   [To-Do](#to-do)


## Installation
This should only be used as a frame of reference, as some of the hardware configuration is specific for my laptop, such as my partitions. However, it can be deployed running:

```
sudo nixos-rebuild switch --flake /etc/nixos#surface --impure
```

After this is ran, the installed ZSH shell will have an alias for the above command called `update`, so that can be run instead.

## To-do
Some more programs have to be added, and some more ways to improve declarability should also be there. 
Firefox extensions so far aren't declared in the files, and I haven't figured out how to use NUR yet with the nixOS home-manager module. 
Some other miscellaneous things, like a status bar (although i don't need one) can be added, although this is commented out in the [`home.nix`](./home.nix) file under the sway module. 






