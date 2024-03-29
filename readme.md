# Dotfiles

Repository for managing configuration files for Arch Linux.

## Preview

![preview](https://raw.githubusercontent.com/blankaex/dotfiles/master/screenshot.png)

* [Start page](https://github.com/blankaex/dawn)
* [Wallpaper](https://whvn.cc/wy1lyr)

## Requirements

* [pyinfra](https://github.com/Fizzadar/pyinfra)

## Installation

```
# packages
$ pyinfra @local deploys/packages/izanami.py

# configs
$ pyinfra @local deploys/configs/izanami.py
```
Or alternatively over SSH:
```
$ pyinfra [HOST] deploys/configs/izanagi.py --user [SSH USERNAME] --key [PATH]
```

## Utilities

* [bspwm](https://github.com/baskerville/bspwm/)
* [sxhkd](https://github.com/baskerville/sxhkd)
* [polybar](https://github.com/polybar/polybar)
* [rofi](https://github.com/davatorium/rofi)
* [dunst](https://dunst-project.org/)
* [alacritty](https://github.com/jwilm/alacritty)
* [zsh](https://www.zsh.org/)
* [prezto](https://github.com/sorin-ionescu/prezto)
* [ranger](https://github.com/ranger/ranger)
* [nvim](https://neovim.io/)
