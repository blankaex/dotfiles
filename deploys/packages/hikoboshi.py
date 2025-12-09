from pyinfra import local

# dependencies
local.include("tasks/packages/git.py")
local.include("tasks/packages/rsync.py")
local.include("tasks/packages/trizen.py")

# shell
local.include("tasks/packages/zsh.py")
local.include("tasks/packages/pywal.py")
local.include("tasks/packages/grc.py")
local.include("tasks/packages/nvim.py")
local.include("tasks/packages/ranger.py")
local.include("tasks/packages/ripgrep.py")
