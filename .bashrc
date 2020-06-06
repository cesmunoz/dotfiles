# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# ~/.bashrc:
###### Exports #####
export REPODIR="/c/repos"

###### Alias #####

# Moving Directories
alias cdrive="cd /c"
alias ..="cd .."

# List
alias ls="ls --color=yes"
alias lsl="ls -l --color=yes"
alias lsa="ls -a"
alias lsal="ls -al"

# Basic Git
alias gs="git status -s"
alias ga="git add -A"
alias gf="git fetch"
alias gcm="git commit -m"

# L
alias jl='j --l'
alias jr='j --r'
alias js='j --s'

# BASH
alias reload=". .bashrc"

###### Functions #####

# Aws
function workenv() {
  echo "Change AWS Working environment to > $1"
  rm ~/.aws/config
  rm ~/.aws/credentials
  cp ~/.aws/$1/config ~/.aws/config
  cp ~/.aws/$1/credentials ~/.aws/credentials
}

# Repo
function repoenv() {
  echo "Change working directory to > $1"
  cd $REPODIR/$1
}

# Serverless
function invokesls() {
  _PATH="$2"    
  if [ -z "$_PATH" ]
  then
      echo "sls invoke local -f $1"
      sls invoke local -f $1
  else    
      echo "sls invoke local -f $1 --path $2"
      sls invoke local -f $1 --path $2
  fi
}


###### BASH CUSTOMIZATION #####
Reset=$(tput sgr0)
Bold=$(tput bold)
Black=$(tput setaf 0)
Red=$(tput setaf 1)
Green=$(tput setaf 2)
Yellow=$(tput setaf 3)
Blue=$(tput setaf 4)
Magenta=$(tput setaf 5)
Cyan=$(tput setaf 6)
White=$(tput setaf 7)

# Bold
BBlack="\[\033[1;30m\]"       # Black
BRed="\[\033[1;31m\]"         # Red
BGreen="\[\033[1;32m\]"       # Green
BYellow="\[\033[1;33m\]"      # Yellow
BBlue="\[\033[1;34m\]"        # Blue
BPurple="\[\033[1;35m\]"      # Purple
BCyan="\[\033[1;36m\]"        # Cyan
BWhite="\[\033[1;37m\]"       # White

# PS1
export oldPS1=$PS1

alias __git_branch="git branch 2>/dev/null | grep '*' | sed 's/* \(.*\)/\1/'"

function is_git_repository {
  git branch > /dev/null 2>&1
}

function set_bash_prompt {
  PS1="$Bold$Green➜ $BCyan\W"  
  if is_git_repository ; then    
    PS1="$PS1$BBlue git:($BRed$(__git_branch)$BBlue)"
  fi

  PS1="$PS1 $Reset"
}

PROMPT_COMMAND=set_bash_prompt

###### ALIAS & FUNCTIONS #####
###### Exports #####
export REPODIR="/mnt/c/repos"

###### Alias #####

# Moving Directories
alias cdrive="cd /c"
alias ..="cd .."

# List
alias ls="ls --color=yes"
alias lsl="ls -l --color=yes"
alias lsa="ls -a"
alias lsal="ls -al"

# Basic Git
alias gs="git status -s"
alias ga="git add -A"
alias gf="git fetch"
alias gcm="git commit -m"

# L
alias jl='j --l'
alias jr='j --r'
alias js='j --s'

# BASH
alias reload=". .bashrc"

###### Functions #####

# Aws
function workenv() {
  echo "Change AWS Working environment to > $1"
  rm ~/.aws/config
  rm ~/.aws/credentials
  cp ~/.aws/$1/config ~/.aws/config
  cp ~/.aws/$1/credentials ~/.aws/credentials
}

# Repo
function repoenv() {
  echo "Change working directory to > $1"
  cd $REPODIR/$1
}

# Serverless
function invokesls() {
  _PATH="$2"    
  if [ -z "$_PATH" ]
  then
      echo "sls invoke local -f $1"
      sls invoke local -f $1
  else    
      echo "sls invoke local -f $1 --path $2"
      sls invoke local -f $1 --path $2
  fi
}

# Deployment
function lighthouse() {
  echo "git push origin $1:/lighthouse/$1"
  git push origin $1:lighthouse/$1
}

###### LOADING FILES #####
source $HOME/.nvm/nvm.sh
source $HOME/z.sh

