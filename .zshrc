# prompt style
#PROMPT='%{%F{#5fd7ff}%}% $USER%{%f%}@%{%F{#00af5f	}%}% $HOST%{%f%}:%{%F{yellow}%}%~%{%f%}$ '
#PROMPT='%~$ '
PROMPT='%{%F{#008080}%}%~%{%f%}$ '

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

HISTCONTROL=ignoreboth

# history 
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=1000

# AWS ansible exports
source ~/.aws/.export_credentials

# settings
#setopt correct_all	#correct misspelled commands
setopt autocd		#cd by typing directory name
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

# Multiple Monitors aliases
alias monitor_mirror='xrandr --output HDMI2 --auto --same-as eDP1 --mode 1920x1080'
alias monitor_independent='xrandr --output HDMI2 --auto --right-of eDP1'
alias monitor_off='xrandr --output HDMI2 --off'

# aliases
alias suspend='sudo systemctl suspend'
alias vim='sudo -E nvim'
alias htop='htop -t'
alias bc='bc -l -q'

# changing wget history location
alias wget="wget --hsts-file ~/.config/wget/wget-hsts"

# disabling less history
export LESSHISTFILE=/dev/null

# goto
alias godwm='cd ~/dotfiles/suckless/dwm-6.2'
alias gost='cd ~/dotfiles/suckless/st-0.8.2'

# export app
export TERM=xterm-256color
export EDITOR=nvim
#export TERM=st-256color
#export TERM=xterm


# export paths
export PATH=$PATH:~/downloads/blender
export PATH=$PATH:~/bin
export PATH=$PATH:~/bin/python
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin
#export PATH=$PATH:/home/andrew/downloads/platform-tools/ # not needed, can't execute ccommands anyway *root needed*
