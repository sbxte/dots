# ZSH CONF

# ZOXIDE (Better cd)
export PATH=$PATH:/home/sbyte/.local/bin
eval "$(zoxide init zsh)"


# NeoVim
export PATH="$PATH:/opt/nvim-linux64/bin"

# Oh My Posh
eval "$(/home/linuxbrew/.linuxbrew/bin/oh-my-posh --init --shell zsh --config ~/repo/omp-config/custom.omp.json)"

# SSH Agent
# (silenced output)
eval `ssh-agent` > /dev/null

# Gpg Agent
export GPG_TTY=$(tty)

# Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Git Completion
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)

autoload -Uz compinit && compinit


#
# Aliases and Binds
#

alias zshrc="source ~/.zshrc"
alias bat="batcat"
alias ls="exa -l"

alias compact_memory="sudo bash -c 'echo 1 > /proc/sys/vm/compact_memory'"
alias drop_caches="sudo bash -c 'echo 1 > /proc/sys/vm/drop_caches'"
alias clnmem="compact_memory; drop_caches;"

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

