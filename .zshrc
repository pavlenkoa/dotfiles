## Prompt
# Left
#PROMPT='%{%F{#5fd7ff}%}% $USER%{%f%}@%{%F{#00af5f	}%}% $HOST%{%f%}:%{%F{yellow}%}%~%{%f%}$ ' # Light blue, green
#PROMPT='%{%F{#00af5f}%}%~%{%f%}$ ' # Light green
#PROMPT='%{%F{#5fd7ff}%}%~%{%f%}$ ' # Light blue
PROMPT='%{%F{yellow}%}%~%{%f%}$ ' # Yellow
#PROMPT='%{%F{#008080}%}%~%{%f%}$ ' # Dark green

# Right
autoload -Uz vcs_info
precmd () { vcs_info }
setopt prompt_subst
RPROMPT="\$vcs_info_msg_0_"
zstyle ':vcs_info:git*' formats "* %{%F{#1EC325}%}% %b%{%f%}"

## Shell settings
#setopt correct_all # Correct misspelled commands
setopt hist_ignore_dups # Prevents the current line from being saved in the history if it is the same as the previous one
setopt globdots # Lets files beginning with a dot be matched without explicitly specifying the dot
setopt ignore_eof # Forces the user to type exit or logout, instead of just pressing ^D
setopt NO_BEEP # NO BEEP
# menu like in bash
setopt noautomenu
setopt nomenucomplete
# vim style bindings
bindkey -v

## Execute when changing work dir
chpwd() {
    ls -a --group-directories-first --color=auto
}

## Autocompletion
# General
autoload -U compinit
compinit -D
# jfrog
source ~/.jfrog/jfrog_zsh_completion
# kubectl
if [ $commands[kubectl] ]; then source <(kubectl completion zsh); fi
# helm
if [ $commands[helm] ]; then source <(helm completion zsh); fi
## gcloud
if [ $commands[gcloud] ]; then source ~/.config/autocompletion/gcloud.plugin.zsh; fi
## aws
if [ $commands[aws] ]; then source ~/.config/autocompletion/aws.plugin.zsh; fi
## ansible
if [ $commands[ansible] ]; then source ~/.config/autocompletion/ansible.plugin.zsh; fi
## buds
compdef _buds buds
function _buds(){
    _describe 'command' "('on:Connect buds' 'off:Disconnect buds' 'clean:Disable bluetooth discover and scanner' 'status:Show information')"
}

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
# openvpn
source ~/misc/openvpn/creds/aliases
# monitors
alias hdmi_mirror='xrandr --output HDMI2 --auto --same-as eDP1 --mode 1920x1080'
alias hdmi_right='xrandr --output HDMI2 --auto --right-of eDP1'
alias hdmi_left='xrandr --output HDMI2 --auto --left-of eDP1'
alias hdmi_ontop='xrandr --output HDMI2 --auto --above eDP1'
alias hdmi_off='xrandr --output HDMI2 --off --output DP1 --off --output eDP1 --auto'
#alias monitor_on='xrandr --output eDP1 --off --output DP1 --primary --mode 1920x1200 --pos 1920x0 --rotate right --output DP2 --off --output HDMI1 --off --output HDMI2 --mode 1920x1200 --pos 0x325 --rotate normal --output VIRTUAL1 --off'
alias dp_on='xrandr --output eDP1 --off --output DP1 --mode 1920x1200 --output VIRTUAL1 --off && background_set'
alias monitor_on='xrandr --output eDP1 --off --output DP1 --mode 1920x1200 --pos 0x325 --rotate normal --rate 75 --output DP2 --off --output HDMI1 --off --output HDMI2 --primary --mode 1920x1200 --pos 1920x0 --rotate right --rate 75 --output VIRTUAL1 --off && background_set'
alias monitor_off='xrandr --output HDMI2 --off --output DP1 --off --output eDP1 --auto'
# nfs mounting
alias showmounted='df -aTh'
alias nfsmount='sudo mount -t nfs4 -o proto=tcp,port=2049 raspberrypi:/ /media/shared/'
alias nfsumount='sudo umount -f /media/shared/'
# S3 bucket mounting
alias bucketmount='s3fs fortnest-bucket /media/bucket/ -o endpoint="eu-central-1"'
alias bucketumount='sudo umount -f /media/bucket/'
# various
alias background_set='feh --no-xinerama --no-fehbg --bg-scale "/home/andrew/misc/wallpapers/full_moon.jpg"'
alias restart_wifi='sudo systemctl restart wpa_supplicant@wlp61s0.service'
alias restart_resolved='sudo systemctl restart systemd-resolved.service'
alias wget="wget --hsts-file ~/.config/wget/wget-hsts"
alias suspend='sudo systemctl suspend'
alias svim='sudo -E nvim'
alias bfg='java -jar ~/bin/java/bfg-1.13.0.jar'
alias vim='nvim'
alias bc='bc -l -q'
alias lint='helm lint'
# terraform
alias t='terraform'
alias ta='terraform apply'
# kubectl
source ~/.dotfiles/etc/aliases/.kubectl_aliases
# goto
alias godwm='cd ~/.dotfiles/suckless/dwm-6.2'
alias gost='cd ~/.dotfiles/suckless/st-0.8.3'
alias gomov='cd /media/shared/movies'
alias gotv='cd /media/shared/tv'

#wireguard vpn
alias up='wg-quick up'
alias down="wg-quick down $(sudo wg show | awk '/interface:/{print $2}')"
compdef _up wg-quick
function _up(){
    _describe 'command' "('england-1' 'germany-1' 'germany-2' 'germany-3' 'netherlands-1' 'netherlands-2' 'poland-1' 'poland-2' 'switzerland-1' 'switzerland-2')"
}

## Exports
# tokens
source /home/andrew/misc/secrets/tokens
# apps
export BROWSER=chromium
export EDITOR=nvim
export TERM=xterm-256color
# paths
export GOPATH=$HOME/bin/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/opt/cisco/anyconnect/bin/
export PATH=$PATH:$HOME/.cabal/bin/
fpath+=${ZDOTDIR:-~}/.zsh_functions
export PATH=$PATH:~/.local/bin
