plugins=(git)

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

newPrompt

###### SHELL ######

# history size
HISTSIZE=5000
HISTFILESIZE=10000
SAVEHIST=5000
setopt EXTENDED_HISTORY
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history

# allow substitution in PS1
setopt promptsubst

# share history across multiple zsh sessions
setopt SHARE_HISTORY
# append to history
setopt APPEND_HISTORY
# adds commands as they are typed, not at shell exit
setopt INC_APPEND_HISTORY
# do not store duplications
setopt HIST_IGNORE_DUPS

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
  cp ~/.aws/$1/config ~/.aws/config
  cp ~/.aws/$1/credentials ~/.aws/credentials
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
function c { code ${@:-.} }

mg () { mkdir "$@" && cd "$@" || exit; }
cdl() { cd "$@" && ll; }
npm-latest() { npm info "$1" | grep latest; }
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

# Presto
alias presto-connect=". ${HOME}/work/jampp/scripts/connect-presto.sh";
alias presto-csv=". ${HOME}/work/jampp/scripts/query-csv.sh";

###### CONFIG CLI APPS ###### 

# N
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

# NVM
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Z
source $HOME/z.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
