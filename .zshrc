# prompt style
#PROMPT='%{%F{#5fd7ff}%}% $USER%{%f%}@%{%F{#00af5f	}%}% $HOST%{%f%}:%{%F{yellow}%}%~%{%f%}$ '
#PROMPT='%{%F{yellow}%}%~%{%f%}$ ' #yellow
PROMPT='%{%F{#008080}%}%~%{%f%}$ ' # dark green

# git branch
autoload -Uz vcs_info
precmd () { vcs_info }
setopt prompt_subst
RPROMPT="\$vcs_info_msg_0_"
zstyle ':vcs_info:git*' formats "* %{%F{#1EC325}%}% %b%{%f%}"
setopt ignore_eof

bindkey -v

# autocompletion
autoload -U compinit
compinit -D

# autocompletion for jfrog
source /home/andrew/.jfrog/jfrog_zsh_completion
# autocompletion for docker, docker-compose
if [ $commands[docker] ]; then source /home/andrew/.config/autocompletion/_docker; fi
if [ $commands[docker-compose] ]; then source /home/andrew/.config/autocompletion/_docker-compose; fi
# autocompletion for kubectl
if [ /usr/bin/kubectl ]; then source <(kubectl completion zsh); fi
# autocompletion for helm
if [ $commands[helm] ]; then source <(helm completion zsh); fi
if [ $commands[helm3] ]; then source <(helm3 completion zsh); fi
# autocompletion for gcloud
if [ $commands[gcloud] ]; then source /home/andrew/.config/autocompletion/gcloud.plugin.zsh; fi
# autocompletion for aws
if [ $commands[aws] ]; then source /home/andrew/.config/autocompletion/aws.plugin.zsh; fi
# autocompletion for ansible
if [ $commands[ansible] ]; then source /home/andrew/.config/autocompletion/ansible.plugin.zsh; fi

HISTCONTROL=ignoreboth

# history
HISTFILE=~/.zsh_history
HISTSIZE=2000
SAVEHIST=2000

# changing wget history location
alias wget="wget --hsts-file ~/.config/wget/wget-hsts"

# disabling less history
export LESSHISTFILE=/dev/null

# AWS ansible exports
source ~/.aws/.export_credentials

# settings
#setopt correct_all	#correct misspelled commands
#setopt autocd           #cd by typing directory name
setopt hist_ignore_dups #ignore repeated commands
setopt NO_BEEP
setopt globdots
setopt noautomenu
setopt nomenucomplete

# enable color support of ls and also add handy aliases
#if [ -x /usr/bin/dircolors ]; then
#    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias ls='ls --group-directories-first --color=auto'
    alias la='ls -a --group-directories-first --color=auto'
    alias ll='ls -alh --group-directories-first --color=auto'
    alias l='ls -CF --group-directories-first --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
#fi

chpwd() {
	ls -a --group-directories-first --color=auto
}

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# multiple monitors aliases
alias hdmi_mirror='xrandr --output HDMI2 --auto --same-as eDP1 --mode 1920x1080'
alias hdmi_right='xrandr --output HDMI2 --auto --right-of eDP1'
alias hdmi_left='xrandr --output HDMI2 --auto --left-of eDP1'
alias hdmi_off='xrandr --output eDP1 --auto && xrandr --output HDMI2 --off && xrandr --output DP1 --off'
alias edp_scale='xrandr --output eDP1 --scale 0.7x0.7'
alias edp_scale_off='xrandr --output eDP1 --scale 1x1'
alias edp_on='xrandr --output eDP1 --brightness 1'
alias edp_off='xrandr --output eDP1 --brightness 0'
alias usbc_mirror='xrandr --output DP1 --auto --same-as eDP1 --mode 1920x1080'
alias usbc_right='xrandr --output DP1 --auto --right-of eDP1'
alias usbc_left='xrandr --output DP1 --auto --left-of eDP1'
alias hdmi_ontop='xrandr --output HDMI2 --auto --above eDP1'
alias monitor_above_usbc='xrandr --output DP1 --auto --above eDP1'
alias monitor_rotate_normal_hdmi='xrandr --output HDMI2 --rotate normal'
alias monitor_rotate_normal_usbc='xrandr --output DP1 --rotate normal'
alias monitor_rotate_right_hdmi='xrandr --output HDMI2 --rotate right'
alias monitor_rotate_right_usbc='xrandr --output DP1 --rotate right'
alias monitor_rotate_left_hdmi='xrandr --output HDMI2 --rotate left'
alias monitor_rotate_left_usbc='xrandr --output DP1 --rotate left'
alias monitor_combo_on='xrandr --output eDP1 --off && xrandr --output DP1 --auto && xrandr --output HDMI2 --auto --left-of DP1 --rotate left'
alias monitor_combo_off='xrandr --output eDP1 --auto && xrandr --output HDMI2 --off && xrandr --output DP1 --off'

# aliases
alias background_set='feh --no-fehbg --bg-scale "/home/andrew/misc/wallpapers/anime-landscape-waterfall-cloud-5k-mq-1920x1080.jpg"'
alias restart_wifi='sudo systemctl restart wpa_supplicant@wlp61s0.service'
alias restart_resolved='sudo systemctl restart systemd-resolved.service'
alias suspend='sudo systemctl suspend'
alias svim='sudo -E nvim'
alias vim='nvim'
alias bc='bc -l -q'
alias k='kubectl'

# mullvad aliases
alias m='mullvad'
alias mc='mullvad connect'
alias md='mullvad disconnect'
alias ms='mullvad status'

# nfs mount aliases
alias showmounted='df -aTh'
alias nfsmount='sudo mount -t nfs4 -o proto=tcp,port=2049 raspberrypi:/media/shared/ /media/shared/'
alias nfsumount='sudo umount -f /media/shared/'

# S3 bucket mounting
alias bucketmount='s3fs fortnest-bucket /media/bucket/ -o endpoint="eu-central-1"'
alias bucketumount='sudo umount -f /media/bucket/'

# goto
alias godwm='cd ~/.dotfiles/suckless/dwm-6.2'
alias gost='cd ~/.dotfiles/suckless/st-0.8.2'
alias gomov='cd /media/shared/movies'
alias gotv='cd /media/shared/tv'

# vpn aliases
source /home/andrew/misc/openvpn/creds/aliases

# export tokens
source /home/andrew/secrets/tokens

# export app
export BROWSER=chromium
export EDITOR=nvim
export TERM=xterm-256color
#export TERM=tmux-256color
#export TERM=st-256color

# export paths
export PATH=$PATH:/opt/cisco/anyconnect/bin/
export PATH=$PATH:~/bin
export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/bin/python
fpath+=${ZDOTDIR:-~}/.zsh_functions

