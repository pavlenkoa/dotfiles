# paths and exports
eval "$(/opt/homebrew/bin/brew shellenv)"       # initialize homebrew
export PATH=$PATH:~/bin                         # add user binaries to path
export PATH=$PATH:~/bin/google-cloud-sdk/bin
export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/go/bin
export PATH=$PATH:~/Library/Python/3.11/bin
export PATH=$PATH:$HOME/Library/Python/3.9/bin
export PATH=$PATH:/usr/local/opt/openssl/bin
export PATH=$PATH:/opt/homebrew/Cellar/openjdk@17/17.0.12/bin
export PATH=$PATH:/opt/homebrew/Cellar/mysql-client/9.3.0/bin
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# environment variables
## editor and terminal
export EDITOR=nvim                              # set neovim as default editor
export VISUAL="$EDITOR"                         # use same editor for visual editing
export TERM=xterm-256color                      # enable 256 color support

## application settings
export K9S_CONFIG_DIR=~/.config/k9s             # k9s configuration directory
export GPG_TTY=$(tty)                           # fix for gpg
export USE_GKE_GCLOUD_AUTH_PLUGIN=True          # enable gcloud auth plugin
export CLICOLOR=1                               # enable color support in terminal

## output formatting
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'  # colored gcc warnings
export LESSHISTFILE=/dev/null                   # disable less history

# history settings
HISTCONTROL=ignoreboth                          # ignore duplicates and commands starting with space
HISTFILE=~/.zsh_history                         # history file location
HISTSIZE=2000                                   # history size in memory
SAVEHIST=2000                                   # history size on disk
setopt hist_ignore_dups                         # ignore duplicate commands

# shell behavior
## general options
setopt ignore_eof                               # prevent accidental exits with ctrl-d
setopt NO_BEEP                                  # disable terminal bell

## menu behavior
setopt noautomenu                               # disable auto menu completion
setopt nomenucomplete                           # disable menu completion
setopt prompt_subst                             # enable prompt substitution

# input controls
## key bindings
bindkey -v                                      # enable vi mode
bindkey '^R' history-incremental-search-backward # reverse history search

## clipboard integration
function vi-yank-xclip {                        # copy to system clipboard in vi mode
    zle vi-yank
    echo "$CUTBUFFER" | pbcopy
}
zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip

# directory navigation
chpwd() {                                       # run after changing directory
    gls -a --group-directories-first --color=auto
}

# completion system
## initialization
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do           # update completion dump once a day
  compinit
done
compinit -C                                     # load completions

## tool-specific completions
if [ $commands[kubectl] ]; then source <(kubectl completion zsh); fi

# prompt configuration
## left prompt
PROMPT='%{%F{yellow}%}%~%{%f%}$ '               # show current directory in yellow

## right prompt (git info)
autoload -Uz vcs_info
precmd () { vcs_info }
RPROMPT="\$vcs_info_msg_0_"
zstyle ':vcs_info:git*' formats "* %{%F{green}%}% %b%{%f%}"

# external sources
## secrets
source ~/.local/grafana-cloud
source ~/.local/vault
source ~/.local/alicloud

## tool configurations
source ~/.config/aliases/.kubectl_aliases

# aliases
## file operations
alias dir='gdir --color=auto'
alias vdir='gvdir --color=auto'
alias ls='gls --group-directories-first --color=auto'
alias la='gls -a --group-directories-first --color=auto'
alias ll='gls -alh --group-directories-first --color=auto'
alias l='gls -CF --group-directories-first --color=auto'
alias grep='ggrep --color=auto'
alias base64='gbase64'

## general utilities
alias h="history -100"                          # show last 100 commands
alias wget="wget --hsts-file ~/.config/wget/wget-hsts"
alias svim='sudo -E nvim'                       # sudo vim with current user config
alias vim='nvim'                                # use neovim
alias cur='cursor -r'                           # use cursor
alias bc='bc -l -q'                             # calculator with math library

## container operations
alias dcommit='docker commit `docker ps -q -l` commited && docker run -it -u0 --network=host --entrypoint=sh commited'
alias docker='podman'                           # use podman instead of docker

## devops tools
alias t='terraform'
alias tg='terragrunt'
alias a='argocd'
alias ac='aliyun'

## python
alias pip='python3 -m pip'
alias pip3='python3 -m pip'