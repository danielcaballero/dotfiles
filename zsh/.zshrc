# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -----------------------------------------------------------------------------
#  Core environment (portable across machines)
# -----------------------------------------------------------------------------
export LANG=en_US.UTF-8
export LC_ALL=$LANG

# Homebrew (Apple‑silicon first, Intel fallback) and user binaries first in PATH
if [[ -d /opt/homebrew/bin ]]; then
  PATH="/opt/homebrew/bin:$HOME/bin:$PATH"
else
  PATH="/usr/local/bin:$HOME/bin:$PATH"
fi
export PATH

# -----------------------------------------------------------------------------
#  Oh‑My‑Zsh & Theme
# -----------------------------------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"   # requires theme installed in $ZSH_CUSTOM/themes

# Auto‑update reminder every 14 days
zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 14

# -----------------------------------------------------------------------------
#  Plugins
# -----------------------------------------------------------------------------
plugins=(
  git
  nvm                       # lazy‑loads nvm
  zsh-autosuggestions       # make sure plugin dirs exist in $ZSH_CUSTOM/plugins
  history-substring-search
  zsh-syntax-highlighting   # must stay last
)

source "$ZSH/oh-my-zsh.sh"

# -----------------------------------------------------------------------------
#  Zsh behaviour tweaks
# -----------------------------------------------------------------------------
setopt AUTO_CD AUTO_PUSHD INC_APPEND_HISTORY HIST_IGNORE_DUPS HIST_REDUCE_BLANKS
zstyle ':completion:*' menu select
COMPLETION_WAITING_DOTS="true"

# -----------------------------------------------------------------------------
#  nvm per‑directory version (requires the nvm plugin)
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
#  Optional: SCM Breeze (comment out if unused)
# -----------------------------------------------------------------------------
[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

