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

* [zsh](https://github.com/zsh-users/zsh)
* [prezto](https://github.com/sorin-ionescu/prezto)
* [nvim](https://github.com/neovim/neovim)
* [lf](https://github.com/gokcehan/lf)
* [alacritty](https://github.com/jwilm/alacritty)
* [bspwm](https://github.com/baskerville/bspwm/)
* [sxhkd](https://github.com/baskerville/sxhkd)
* [polybar](https://github.com/polybar/polybar)
* [rofi](https://github.com/davatorium/rofi)
* [dunst](https://github.com/dunst-project/dunst)
