# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$HOME/.zsh_custom

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(ruby rvm vim-interaction gitfast zsh-autosuggestions zsh-history-substring-search zsh-git-scripts)

# User configuration

PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/lennaert/.local/bin"
export PATH="$HOME/bin:$HOME/.rbenv/shims:$HOME/.rbenv/bin:$HOME/perl5/bin:$HOME/.rvm/bin:$PATH"

source $ZSH/oh-my-zsh.sh
source $HOME/.aliases.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export EDITOR='nvim'
export VISUAL='nvim'

# Show timestamp in history command
alias history="fc -il 1"

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

if [ -f "$HOME/.zshrc_private" ]; then
  if [ -x "$HOME/.zshrc_private" ]; then
    . "$HOME/.zshrc_private"
  else
    echo ".zshrc_private is not executable. Not executed."
  fi
fi

# Same Ctrl-u behavior as bash
bindkey '^U' backward-kill-line
bindkey '^Y' yank

alias gs="_zsh_git_scripts_git_status"
alias gl="_zsh_git_scripts_git_log"
alias gll="_zsh_git_scripts_git_log_all"
alias ga="$HOME/.zsh_custom/plugins/zsh-git-scripts/git-choose-files-from-status.zsh | xargs -t -o git add $@"
alias gr="$HOME/.zsh_custom/plugins/zsh-git-scripts/git-choose-files-from-status.zsh | xargs -t -o git reset $@"
# These bindings also seem to bind <M-...>, which is what I was after

# Bind <Esc>s (and alt-s) to show the numbered git status
bindkey -s '\es' 'gs\n'
# Bind <Esc>a to 'git add -p'
bindkey -s '\ea' 'git add -p\n'
# Bind <Esc>g to 'git log --oneline --decorate -n 10'
bindkey -s '\eg' 'gl\n'
# Bind <Esc>G to 'git log --oneline --decorate'
bindkey -s '\eG' 'gll\n'
# Bind <Esc>r to 'gbr' (git branch)
bindkey '\er' _zsh_git_scripts_git_choose_branch
# Bind <Esc>R to 'gbrr' (git branch --remote)
bindkey '\eR' _zsh_git_scripts_git_choose_remote_branch

# Bind <Esc>c to 'git diff' (Previously: Uppercase sentence and move to next sentence)
bindkey -s '\ec' 'git diff\n'

# Bind <Esc>C to 'git diff'
bindkey -s '\eC' 'git diff --cached\n'

bindkey '\ex' _zsh_git_scripts_expand_indices

alias gd=_zsh_git_scripts_git_diff
alias gdc="_zsh_git_scripts_git_diff --cached"
unsetopt nomatch

alias -g D=$HOME/Downloads

# [ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"

[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if (which exa >/dev/null); then
  alias ls=`which exa`
fi

if (which bat >/dev/null); then
  alias cat="`which bat`"
fi

# Near unlimited history
export HISTSIZE=10000000
export SAVEHIST=10000000

[ -f $HOME/.config/broot/launcher/bash/br ] && source $HOME/.config/broot/launcher/bash/br

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="$HOME/.cargo/bin:$PATH"

export BAT_THEME="Solarized (dark)"
