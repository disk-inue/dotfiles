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

# Load the theme
antigen theme robbyrussell
# antigen theme romkatv/powerlevel10k

# Tell antigen that you're done
antigen apply

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
# [[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# python
export PYENV_ROOT="$HOME/.config/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# alias
alias ls='ls -F --color=auto'
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
abbr -S lg='lazygit' >>/dev/null

# nodenv
export NODENV_ROOT="$HOME/.config/.nodenv"
eval "$(nodenv init -)"

# rbenv
export RBENV_ROOT="$HOME/.config/.rbenv"
eval "$(rbenv init - zsh)"

# goenv
export GOENV_ROOT="$HOME/.config/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"

# rust
export RUSTUP_HOME="$HOME/.config/.cargo"
export CARGO_HOME="$HOME/.config/.cargo"
export PATH="$CARGO_HOME/bin:$PATH"
source "$HOME/.config/.cargo/env"

# jenv
export JENV_ROOT="$HOME/.config/.jenv"
export PATH="$JENV_ROOT/bin:$PATH"
eval "$(jenv init -)"

# fzf
[ -f ~/.local/bin/.fzf.zsh ] && source ~/.local/bin/.fzf.zsh

# starship
eval "$(starship init zsh)"

# tmux
# if [ $SHLVL = 1 ]; then
    # tmux
# fi

