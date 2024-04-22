export ZSH="/Users/cesmunoz/.oh-my-zsh"

ZSH_THEME="awesomepanda"
if [[ -d "$HOME/.oh-my-zsh" ]]; then
  source $ZSH/oh-my-zsh.sh
fi

#### PERSONAL CONFIGURATION ####

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

# Github
alias ghwho="gh config get user -h github.com";

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

# VSCode
function c() {
  code $1 
}

function ci() {
  code-insiders $1
}

mg () { mkdir "$@" && cd "$@" || exit; }
killport() { lsof -i tcp:"$*" | awk 'NR!=1 {print $2}' | xargs kill -9 ;}

# Z
. /opt/homebrew/etc/profile.d/z.sh