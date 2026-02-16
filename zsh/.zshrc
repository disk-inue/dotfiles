# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  # source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# setting
umask 022
limit coredumpsize 0
bindkey -d
bindkey -e

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

# antigen
source $HOME/.local/bin/antigen.zsh

# Load the oh-my-zsh's library
antigen use oh-my-zsh

antigen bundles <<EOBUNDLES
    # Bundles from the default repo (robbyrussell's oh-my-zsh)
    git

    # Syntax highlighting bundle.
    zsh-users/zsh-syntax-highlighting

    # Fish-like auto suggestions
    zsh-users/zsh-autosuggestions

    # Extra zsh completions
    zsh-users/zsh-completions

    # prowpt
    # alpaca-honke/prowpt --branch=main

    # z
    rupa/z z.sh

    # abbr
    olets/zsh-abbr@main
EOBUNDLES

# Load the theme (starshipを使うのでantigenのテーマは無効化)
# antigen theme robbyrussell
# antigen theme romkatv/powerlevel10k

# Tell antigen that you're done
antigen apply

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
# [[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# python
export PYENV_ROOT="$HOME/.config/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# haskell (ghcup)
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"

# alias
alias ls='ls -FG'
alias vim='nvim'

abbr -S ll='ls -l' >>/dev/null
abbr -S la='ls -A' >>/dev/null
abbr -S lla='ls -l -A' >>/dev/null
abbr -S v='vim' >>/dev/null
abbr -S g='git' >>/dev/null
abbr -S gst='git status' >>/dev/null
abbr -S gsw='git switch' >>/dev/null
abbr -S gbr='git branch' >>/dev/null
abbr -S gfe='git fetch' >>/dev/null
abbr -S gpl='git pull' >>/dev/null
abbr -S gad='git add' >>/dev/null
abbr -S gcm='git commit' >>/dev/null
abbr -S gmg='git merge' >>/dev/null
abbr -S gpsh='git push' >>/dev/null
# lazygit: worktree切り替え後にシェルのカレントディレクトリも追従させる
lg() {
  export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir
  lazygit "$@"
  if [ -f "$LAZYGIT_NEW_DIR_FILE" ]; then
    cd "$(cat "$LAZYGIT_NEW_DIR_FILE")"
    rm -f "$LAZYGIT_NEW_DIR_FILE"
  fi
}

# mise
eval "$(mise activate zsh)"

# fzf
[ -f ~/.local/bin/.fzf.zsh ] && source ~/.local/bin/.fzf.zsh

# starship
eval "$(starship init zsh)"

# tmux
# if [ $SHLVL = 1 ]; then
    # tmux
# fi

# work-logs: terminal command logging
work_logs_preexec() {
  local LOG_DIR="$HOME/.work-logs"
  local LOG_FILE="$LOG_DIR/$(date +'%Y-%m-%d').log"
  local TIMESTAMP=$(date +'%Y-%m-%d %H:%M:%S')
  echo "$TIMESTAMP [TERM] [$PWD] $1" >> "$LOG_FILE"
}
autoload -Uz add-zsh-hook
add-zsh-hook preexec work_logs_preexec
