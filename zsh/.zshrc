# -----------------------------------------------------------------------------
#  Powerlevel10k instant-prompt preamble  (keep this at the very top!)
# -----------------------------------------------------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -----------------------------------------------------------------------------
#  Core environment  (portable across machines)
# -----------------------------------------------------------------------------
export LANG=en_US.UTF-8
export LC_ALL=$LANG

# -----------------------------------------------------------------------------
#  PATH: Homebrew (Apple-silicon first, Intel fallback) and user binaries first
# -----------------------------------------------------------------------------
if [[ -d /opt/homebrew/bin ]]; then
  PATH="/opt/homebrew/bin:$HOME/bin:$PATH"
else
  PATH="/usr/local/bin:$HOME/bin:$PATH"
fi
export PATH

# -----------------------------------------------------------------------------
#  Oh-My-Zsh & Powerlevel10k theme
# -----------------------------------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"   # theme must exist in $ZSH_CUSTOM/themes

# -----------------------------------------------------------------------------
#  Oh-My-Zsh auto-update
# -----------------------------------------------------------------------------
zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 14          # days

# -----------------------------------------------------------------------------
#  Plugins
# -----------------------------------------------------------------------------
plugins=(
  git
  nvm                       # lazy-loads nvm
  zsh-autosuggestions
  history-substring-search
  zsh-syntax-highlighting   # must be last
)

source "$ZSH/oh-my-zsh.sh"

# -----------------------------------------------------------------------------
#  Zsh behaviour tweaks
# -----------------------------------------------------------------------------
setopt AUTO_CD AUTO_PUSHD INC_APPEND_HISTORY HIST_IGNORE_DUPS HIST_REDUCE_BLANKS
zstyle ':completion:*' menu select
COMPLETION_WAITING_DOTS="true"

# -----------------------------------------------------------------------------
#  nvm per-directory version (requires the nvm plugin)
# -----------------------------------------------------------------------------
autoload -U add-zsh-hook
load-nvmrc() {
  local nvmrc_path="$(nvm_find_nvmrc)"
  [[ -n $nvmrc_path ]] && nvm use --silent
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# -----------------------------------------------------------------------------
#  Aliases & utilities
# -----------------------------------------------------------------------------
alias please='sudo $(fc -ln -1)'
alias ll='ls -lAh'

# -----------------------------------------------------------------------------
#  SCM Breeze
# -----------------------------------------------------------------------------
[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"

# -----------------------------------------------------------------------------
#  Powerlevel10k theme config (load at the very end)
# -----------------------------------------------------------------------------
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
eval "$(rbenv init - zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
