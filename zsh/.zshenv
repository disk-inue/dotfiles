# XDG
export XDG_CONFIG_HOME=${HOME}/.config
export XDG_CACHE_HOME=${HOME}/.cache
export XDG_DATA_HOME=${HOME}/.local/share
export XDG_STATE_HOME=${HOME}/.local/state

# path
export PATH=${HOME}/.local/bin:$PATH
export PATH="/usr/local/sbin:$PATH"

# lang
export LANGUAGE="en_US.UTF-8"
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="${LANGUAGE}"

# editor
export EDITOR=nvim
export CVSEDITOR="${EDITOR}"
export SVN_EDITOR="${EDITOR}"
export GIT_EDITOR="${EDITOR}"

# history
export HISTFILE=${HOME}/.config/zsh/.zsh_history
export HISTSIZE=10000
export SAVEHIST=100000
export HISTFILESIZE=100000
setopt hist_ignore_dups
setopt EXTENDED_HISTORY
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_verify
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_no_store
setopt hist_expand
setopt share_history

# other
export LISTMAX=50
unsetopt bg_nice
setopt list_packed
setopt no_beep
unsetopt list_types

# antigen
export _ANTIGEN_INSTALL_DIR=${HOME}/.local/bin

# libpq
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# fzf
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

# The next line updates PATH for the Google Cloud SDK.
if [ -f "${HOME}/.local/bin/google-cloud-sdk/path.zsh.inc" ]; then . "${HOME}/.local/bin/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "${HOME}/.local/bin/google-cloud-sdk/completion.zsh.inc" ]; then . "${HOME}/.local/bin/google-cloud-sdk/completion.zsh.inc"; fi

# 環境固有の機密情報を読み込み
if [[ -f "${XDG_CONFIG_HOME}/zsh/.env.local" ]]; then
  source "${XDG_CONFIG_HOME}/zsh/.env.local"
fi
