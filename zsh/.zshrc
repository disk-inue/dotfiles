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

