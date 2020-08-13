alias orig='cd `git rev-parse --show-toplevel` ; git status --untracked --porcelain | grep "^\\?\\?" | awk -e "{ print \$2; }" | grep "\\(\\.orig$\\)\\|\\.\\(BACKUP\\|BASE\\|LOCAL\\|REMOTE\\)\\." | xargs rm'
alias gti='git'
alias igt='git'
alias qgit='git'

alias brrr='brr'
alias brrrr='brr'
alias brrrrr='brr'
alias brrrrrr='brr'

alias be='bundle exec'

alias conf="cd ~/projects/dotfiles"

alias o='xdg-open'

alias vi='nvim'
alias vim='nvim'

alias nq='swallow nvim-qt --nofork'

alias k1='kill %1'
alias k91='kill -9 %1'

alias sa='ssh-add'

alias aptup='sudo apt-get update && sudo apt-get upgrade'

# Select package.json script with fzf
alias y="jq '.scripts | keys | .[]' package.json | fzf --exit-0 --prompt=\"yarn> \" --preview \"jq '.scripts | .\\\"{}\\\"' package.json\" --preview-window down:1:noborder --color 'preview-bg:#223344,border:#778899' | xargs --no-run-if-empty yarn"

# File browser: broot
alias d=br

cl() { if [ -d "$1" ]; then cd "$1"; ls -l; else echo "*** Directory not found ***" ; fi; }

alias yas='yadm status'
alias yal='yadm log'
alias yap='yadm add -p'
alias yad='yadm diff'
alias yadc='yadm diff --cached'

# Allow custom aliases per environment
[[ -x "$HOME/.aliases_private.sh" ]] && . "$HOME/.aliases_private.sh"
