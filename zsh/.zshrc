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

# starship
eval "$(starship init zsh)"

