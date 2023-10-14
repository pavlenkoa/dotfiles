# Prompt
# Left
PROMPT='%m %{%F{yellow}%}%~%{%f%}$ ' # Yellow
# Right
autoload -Uz vcs_info
precmd () { vcs_info }
setopt prompt_subst
RPROMPT="\$vcs_info_msg_0_"
#zstyle ':vcs_info:git*' formats "* %{%F{#1EC325}%}% %b%{%f%}"
zstyle ':vcs_info:git*' formats "* %{%F{green}%}% %b%{%f%}"

## Shell settings
#setopt correct_all # Correct misspelled commands
setopt hist_ignore_dups # Prevents the current line from being saved in the history if it is the same as the previous one
setopt globdots # Lets files beginning with a dot be matched without explicitly specifying the dot
setopt ignore_eof # Forces the user to type exit or logout, instead of just pressing ^D
setopt NO_BEEP # NO BEEP
# menu like in bash
setopt noautomenu
setopt nomenucomplete
# vi mode
bindkey -v
# reverse search
bindkey '^R' history-incremental-search-backward

# Yank to the system clipboard
function vi-yank-xclip {
    zle vi-yank
   echo "$CUTBUFFER" | xclip -sel clipboard
}

zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip

## Execute when changing work dir
chpwd() {
    ls -a --group-directories-first --color=auto
}

### Autocompletion
## General
autoload -U compinit
compinit -D
## jfrog
#source ~/.jfrog/jfrog_zsh_completion
## kubectl
if [ $commands[kubectl] ]; then source <(kubectl completion zsh); fi
## helm
if [ $commands[helm] ]; then source <(helm completion zsh); fi
## gcloud
if [ -f '/Users/andrii/git/dotfiles/bin/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/andrii/git/dotfiles/bin/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/Users/andrii/git/dotfiles/bin/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/andrii/git/dotfiles/bin/google-cloud-sdk/completion.zsh.inc'; fi
## aws
if [ $commands[aws] ]; then source ~/git/dotfiles/.config/autocompletion/aws.plugin.zsh; fi
## ansible
if [ $commands[ansible] ]; then source ~/git/dotfiles/.config/autocompletion/ansible.plugin.zsh; fi

## History
HISTCONTROL=ignoreboth
HISTFILE=~/.zsh_history
HISTSIZE=2000
SAVEHIST=2000
export LESSHISTFILE=/dev/null # Disabling less history

## Colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

## Aliases
# color support
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias ls='ls --group-directories-first --color=auto'
    alias la='ls -a --group-directories-first --color=auto'
    alias ll='ls -alh --group-directories-first --color=auto'
    alias l='ls -CF --group-directories-first --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
# various
alias h="history -100"
alias wget="wget --hsts-file ~/.config/wget/wget-hsts"
alias svim='sudo -E nvim'
alias vim='nvim'
alias bc='bc -l -q'
alias lint='helm lint'
alias dcommit='docker commit `docker ps -q -l` commited && docker run -it -u0 --network=host --entrypoint=sh commited'
# terraform
alias t='terraform'
alias ta='terraform apply'
# terragrunt
alias tg='terragrunt'
alias tga='terragrunt run'
alias tgal='terragrunt run-all'
# argocd
alias a='argocd'
# kubectl
source ~/.config/aliases/.kubectl_aliases
# python
alias pip='python3 -m pip'
alias pip3='python3 -m pip'
alias python='python3'

## Exports
# terminal color support
export CLICOLOR=1
# apps
export EDITOR=nvim
export VISUAL="$EDITOR"
export TERM=xterm-256color
# paths
export PATH=$PATH:~/bin
# gpg
export GPG_TTY=$(tty)
# plugin
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

