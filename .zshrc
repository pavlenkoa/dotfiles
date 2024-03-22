# Prompt
# Left
PROMPT='%{%F{yellow}%}%~%{%f%}$ '
# Right
autoload -Uz vcs_info
precmd () { vcs_info }
setopt prompt_subst
RPROMPT="\$vcs_info_msg_0_"
zstyle ':vcs_info:git*' formats "* %{%F{green}%}% %b%{%f%}"

## Exports
export K9S_CONFIG_DIR=~/.config/k9s
# terminal color support
export CLICOLOR=1
# apps
export EDITOR=nvim
export VISUAL="$EDITOR"
export TERM=xterm-256color
# paths
export PATH=$PATH:/opt/homebrew/bin
export PATH=$PATH:~/bin
export PATH=$PATH:~/bin/google-cloud-sdk/bin
export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/go/bin
# gpg
export GPG_TTY=$(tty)
# plugins
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

## Shell settings
setopt hist_ignore_dups # Prevents the current line from being saved in the history if it is the same as the previous one
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
   echo "$CUTBUFFER" | pbcopy -i
}

zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip

## Execute when changing work dir
chpwd() {
    gls -a --group-directories-first --color=auto
}

### Autocompletion
## General
#export ZDOTDIR=~/.local/
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C
## kubectl
if [ $commands[kubectl] ]; then source <(kubectl completion zsh); fi
## helm
if [ $commands[helm] ]; then source <(helm completion zsh); fi
## gcloud
#if [ -f '/Users/andrii/git/dotfiles/bin/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/andrii/git/dotfiles/bin/google-cloud-sdk/path.zsh.inc'; fi
#if [ -f '/Users/andrii/git/dotfiles/bin/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/andrii/git/dotfiles/bin/google-cloud-sdk/completion.zsh.inc'; fi
## aws
#if [ $commands[aws] ]; then source ~/git/dotfiles/.config/autocompletion/aws.plugin.zsh; fi
## ansible
#if [ $commands[ansible] ]; then source ~/git/dotfiles/.config/autocompletion/ansible.plugin.zsh; fi

## History
HISTCONTROL=ignoreboth
HISTFILE=~/.zsh_history
HISTSIZE=2000
SAVEHIST=2000
export LESSHISTFILE=/dev/null # Disabling less history

## Colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

## Secrets
source ~/.local/grafana-cloud
source ~/.local/vault

## Aliases
# GNU grep and ls, color support
alias dir='gdir --color=auto'
alias vdir='gvdir --color=auto'
alias ls='gls --group-directories-first --color=auto'
alias la='gls -a --group-directories-first --color=auto'
alias ll='gls -alh --group-directories-first --color=auto'
alias l='gls -CF --group-directories-first --color=auto'
alias grep='ggrep --color=auto'
alias base64='gbase64'
# various
alias h="history -100"
alias wget="wget --hsts-file ~/.config/wget/wget-hsts"
alias svim='sudo -E nvim'
alias vim='nvim'
alias bc='bc -l -q'
alias dcommit='docker commit `docker ps -q -l` commited && docker run -it -u0 --network=host --entrypoint=sh commited'
# terraform
alias t='terraform'
# terragrunt
alias tg='terragrunt'
# argocd
alias a='argocd'
# alibaba
alias ac='aliyun'
# kubectl
source ~/.config/aliases/.kubectl_aliases
# python
alias pip='python3 -m pip'
alias pip3='python3 -m pip'
alias python='python3'

