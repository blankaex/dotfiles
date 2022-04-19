from pyinfra import local

# shell
local.include("tasks/configs/git.py")
local.include("tasks/configs/zsh.py")
local.include("tasks/configs/pywal.py")
local.include("tasks/configs/nvim.py")
local.include("tasks/configs/ranger.py")
