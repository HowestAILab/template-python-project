#! Change the {USER} to your username

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH:/home/{USER}/.local/bin

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme (for more themes https://github.com/ohmyzsh/ohmyzsh/wiki/Themes)
ZSH_THEME="half-life"

# Plugins
plugins=(
        git
        zsh-autosuggestions
)

# Source oh-my-zsh (activating oh-my-zsh)
source $ZSH/oh-my-zsh.sh

# Aliases

## Git
alias ga="git add ."
alias gp="git push"

## Poetry
alias pos="poetry shell"
alias pc="poe commit"
alias pcr="poe cretry"

## Yarn/ web development
alias yl="yarn lint"
alias czr="cz --retry"
alias ys="yarn serve --fix"
alias deploy="git checkout master && git merge develop && gp && git checkout develop"

## Other
alias src="source ~/.zshrc" # easy way to source the zshrc file (when config is changed or doesn't load properly)
