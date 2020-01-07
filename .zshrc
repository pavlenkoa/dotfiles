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

bindkey -v

# autocompletion
autoload -U compinit
compinit

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

# AWS ansible exports
source ~/.aws/.export_credentials

# settings
#setopt correct_all	#correct misspelled commands
setopt autocd           #cd by typing directory name
setopt hist_ignore_dups #ignore repeated commands
setopt NO_BEEP
setopt globdots
setopt noautomenu
setopt nomenucomplete

# enable color support of ls and also add handy aliases
#if [ -x /usr/bin/dircolors ]; then
#    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    #alias ls='ls --color=auto'
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
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# multiple monitors aliases
alias monitor_mirror_hdmi='xrandr --output HDMI2 --auto --same-as eDP1 --mode 1920x1080'
alias monitor_mirror_usbc='xrandr --output DP1 --auto --same-as eDP1 --mode 1920x1080'
alias monitor_rightof_hdmi='xrandr --output HDMI2 --auto --right-of eDP1'
alias monitor_rightof_usbc='xrandr --output DP1 --auto --right-of eDP1'
alias monitor_leftof_hdmi='xrandr --output HDMI2 --auto --left-of eDP1'
alias monitor_leftof_usbc='xrandr --output DP1 --auto --left-of eDP1'
alias monitor_above_hdmi='xrandr --output HDMI2 --auto --above eDP1'
alias monitor_above_usbc='xrandr --output DP1 --auto --above eDP1'
alias monitor_rotate_normal_hdmi='xrandr --output HDMI2 --rotate normal'
alias monitor_rotate_normal_usbc='xrandr --output DP1 --rotate normal'
alias monitor_rotate_right_hdmi='xrandr --output HDMI2 --rotate right'
alias monitor_rotate_right_usbc='xrandr --output DP1 --rotate right'
alias monitor_rotate_left_hdmi='xrandr --output HDMI2 --rotate left'
alias monitor_rotate_left_usbc='xrandr --output DP1 --rotate left'
alias monitor_combo_on='xrandr --output eDP1 --off && xrandr --output DP1 --auto && xrandr --output HDMI2 --auto --left-of DP1 --rotate left'
alias monitor_combo_off='xrandr --output eDP1 --auto && xrandr --output HDMI2 --off && xrandr--output DP1 --off'

# aliases
alias background_set='feh --no-fehbg --bg-scale /home/andrew/misc/wallpapers/mandalorian/mandalorian_cave.jpg'
alias restart_wifi='sudo systemctl restart wpa_supplicant@wlp61s0.service'
alias restart_resolved='sudo systemctl restart systemd-resolved.service'
alias suspend='sudo systemctl suspend'
alias svim='sudo -E nvim'
alias vim='nvim'
alias bc='bc -l -q'
alias k='kubectl'

# nessus start/stop aliases
alias nessusstart='sudo /misc/init.d/nessusd start'
alias nessusstop='sudo /misc/init.d/nessusd stop'

# nfs mount aliases
alias showmounted='df -aTh'
alias nfsmount='sudo mount -t nfs4 -o proto=tcp,port=2049 raspberrypi:/media/shared/ /media/shared/'
alias nfsumount='sudo umount -f /media/shared/'

# S3 bucket mounting
alias bucketmount='s3fs fortnest-bucket /media/bucket/ -o endpoint="eu-central-1"'
alias bucketumount='sudo umount -f /media/bucket/'

# vpn aliases
source /home/andrew/misc/openvpn/creds/aliases

# changing wget history location
alias wget="wget --hsts-file ~/.config/wget/wget-hsts"

# disabling less history
export LESSHISTFILE=/dev/null

# goto
alias godwm='cd ~/dotfiles/suckless/dwm-6.2'
alias gost='cd ~/dotfiles/suckless/st-0.8.2'
alias gomov='cd /media/shared/movies'

# export app
export BROWSER=chromium
export EDITOR=nvim
export TERM=xterm-256color
#export TERM=tmux-256color
#export TERM=st-256color

# export paths
export WINEPREFIX="/home/andrew/.local/share/Steam/steamapps/compatdata/683320/pfx"
export PROTON="/home/andrew/.local/share/Steam/steamapps/common/Proton 4.11"
#export WINEPREFIX=/home/andrew/.wine
export PATH=$PATH:/snap/bin
export PATH=$PATH:/home/andrew/.local/bin
export PATH=$PATH:/opt/cisco/anyconnect/bin/
export PATH=$PATH:~/downloads/blender
export PATH=$PATH:~/bin
export PATH=$PATH:~/bin/python
export GOPATH=/home/andrew/bin/go/golibs
export GOPATH=$GOPATH:/home/andrew/bin/go/gocode
export PATH=$PATH:/usr/local/go/bin

#export PATH=$PATH:/home/andrew/downloads/platform-tools/ # not needed, can't execute commands anyway *root needed*
