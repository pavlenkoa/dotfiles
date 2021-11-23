# Prompt
# Left
PROMPT='%{%F{yellow}%}%~%{%f%}$ ' # Yellow
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

# Yank to the system clipboard
function vi-yank-xclip {
    zle vi-yank
   echo "$CUTBUFFER" | pbcopy -i
}

zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip

## Execute when changing work dir
chpwd() {
    gls -a --group-directories-first --color=auto
}

## Autocompletion
# General
autoload -U compinit
compinit -D
# jfrog
#source ~/.jfrog/jfrog_zsh_completion
# kubectl
if [ $commands[kubectl] ]; then source <(kubectl completion zsh); fi
## helm
if [ $commands[helm] ]; then source <(helm completion zsh); fi
### gcloud
if [ $commands[gcloud] ]; then source ~/.dotfiles/.config/autocompletion/gcloud.plugin.zsh; fi
### aws
if [ $commands[aws] ]; then source ~/.dotfiles/.config/autocompletion/aws.plugin.zsh; fi
### ansible
if [ $commands[ansible] ]; then source ~/.dotfiles/.config/autocompletion/ansible.plugin.zsh; fi

## History
HISTCONTROL=ignoreboth
HISTFILE=~/.zsh_history
HISTSIZE=2000
SAVEHIST=2000
export LESSHISTFILE=/dev/null # Disabling less history

## Colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

## Aliases
# GNU grep and ls, color support
alias dir='gdir --color=auto'
alias vdir='gvdir --color=auto'
alias ls='gls --group-directories-first --color=auto'
alias la='gls -a --group-directories-first --color=auto'
alias ll='gls -alh --group-directories-first --color=auto'
alias l='gls -CF --group-directories-first --color=auto'
alias grep='ggrep --color=auto'
# openvpn
#source ~/misc/openvpn/creds/aliases
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
# kubectl
source ~/.dotfiles/.config/aliases/.kubectl_aliases
# nfs mounting
alias showmounted='df -aTh'
alias nfsmount='sudo mount -o resvport -t nfs 192.168.1.2:/media/shared /private/nfs'
alias nfsumount='sudo umount -f /Volumes/nfs/'
alias pip='python -m pip'
alias pip3='python -m pip'

## Exports
# tokens
source ~/misc/secrets/tokens
# terminal color support
export CLICOLOR=1
# apps
export EDITOR=nvim
export VISUAL="$EDITOR"
export TERM=xterm-256color
# paths
#fpath+=${ZDOTDIR:-~}/.zsh_functions
export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/bin
