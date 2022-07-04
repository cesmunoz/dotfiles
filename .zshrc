# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/cesmunoz/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

if [[ -d "$HOME/.oh-my-zsh" ]]; then
  source $ZSH/oh-my-zsh.sh
fi

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


###### PROMPT ######

export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS=Fafacxdxbxegedabagacad

BLACK=$(tput setaf 0);
RED=$(tput setaf 1);
GREEN=$(tput setaf 2);
YELLOW=$(tput setaf 3);
BLUE=$(tput setaf 4);
MAGENT=$(tput setaf 5);
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7);
RESET=$(tput sgr0);


function git_branch {
  # Shows the current branch if in a git repository
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\ \(\1\)/';
}

newPrompt () {
  DISPLAY_DIR='$(dirs)'
  DISPLAY_BRANCH='$(git_branch)'
  PROMPT="%B${GREEN}➜%b ${YELLOW}${DISPLAY_DIR}%B${CYAN}${DISPLAY_BRANCH}%b${RESET} "$'\n'"$ ";
  #PROMPT="${GREEN}➜ ${YELLOW}${DISPLAY_DIR}${GREEN}${DISPLAY_BRANCH}${RESET} $ "
}

# newPrompt

###### SHELL ######

# history size
HISTSIZE=5000
HISTFILESIZE=10000
SAVEHIST=5000
# setopt EXTENDED_HISTORY
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history

# allow substitution in PS1
# setopt promptsubst

# share history across multiple zsh sessions
# setopt SHARE_HISTORY
# append to history
# setopt APPEND_HISTORY
# adds commands as they are typed, not at shell exit
# setopt INC_APPEND_HISTORY
# do not store duplications
# setopt HIST_IGNORE_DUPS

###### ALIAS ######

# Move between directories
alias ..="cd ../";
alias ..l="cd ../ && ll";
alias de="cd ~/Desktop";
alias d="cd ~/repos";

# List
alias ls="ls"
alias lsl="ls -l"
alias lsa="ls -a"
alias lsal="ls -al"
alias ll="ls -1a";

# Zshrc
alias vz="vim ~/.zshrc";
alias cz="code ~/.zshrc";
alias cg="code ~/.gitconfig";
alias vinit="vim ~/.config/nvim/init.vim"

# BASH
alias sz="source ~/.zshrc";
alias reload="source ~/.zshrc"

# Finder
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias deleteDSFiles="find . -name '.DS_Store' -type f -delete"
alias flushdns="sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder"

# Git
function gc { git commit -m "$@"; }
alias gs="git status -s"
alias ga="git add -A"
alias gf="git fetch"
alias gcm="git commit -m"
alias gp="git pull";
alias gpush="git push";
alias gd="git diff";
alias ga="git add .";
dif() { git diff --color --no-index "$1" "$2" | diff-so-fancy; }
cdiff() { code --diff "$1" "$2"; }

## Npm
alias ni="npm install";
alias nrs="npm run start -s --";
alias nrb="npm run build -s --";
alias nrd="npm run dev -s --";
alias nrt="npm run test -s --";
alias nrtw="npm run test:watch -s --";
alias nrv="npm run validate -s --";
alias rmn="rm -rf node_modules";
alias flush-npm="rm -rf node_modules package-lock.json && npm i && say NPM is done";
alias nicache="npm install --prefer-offline";
alias nioff="npm install --offline";

## Yarn
alias yar="yarn run";
alias yas="yarn run start";
alias yab="yarn run build";
alias yat="yarn run test";
alias yav="yarn run validate";
alias yoff="yarn add --offline";
alias ypm="echo \"Installing deps without lockfile and ignoring engines\" && yarn install --no-lockfile --ignore-engines"

alias fsnd="./bin/start-no-docker";
alias fswd="./bin/start-docker";

## AWS
alias awswhoami="aws sts get-caller-identity";

# Neovim
alias vim="nvim"
alias oldvim="\vim"

###### CUSTOM FUNCTIONS ######

# Aws
function workenv() {
  echo "Change AWS Working environment to > $1"
  rm ~/.aws/config
  rm ~/.aws/credentials
  rm ~/.aws/whoami
  cp ~/.aws/$1/config ~/.aws/config
  cp ~/.aws/$1/credentials ~/.aws/credentials
  cp ~/.aws/$1/whoami ~/.aws/whoami
}

# Serverless
function invokesls() {
  _PATH="$2"    
  if [ -z "$_PATH" ]
  then
      echo "sls invoke local -f $1 --stage local"
      sls invoke local -f $1 --stage local
  else    
      echo "sls invoke local -f $1 --path $2 --stage local"
      sls invoke local -f $1 --path $2 --stage local
  fi
}

# VSCode
function c() {
  code $1 
}
mg () { mkdir "$@" && cd "$@" || exit; }
cdl() { cd "$@" && ll; }
killport() { lsof -i tcp:"$*" | awk 'NR!=1 {print $2}' | xargs kill -9 ;}
function quit () {
  if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: quit appname"
  else
    for appname in $1; do
    osascript -e 'quit app "'$appname'"'
    done
  fi
}

###### CONFIG CLI APPS ###### 

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# N
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

# Z
source $HOME/z.sh

# NVM
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval $(/opt/homebrew/bin/brew shellenv)

eval "$(starship init zsh)"
