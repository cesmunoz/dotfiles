export ZSH="/home/cesmunoz/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

######  FUNCTIONS #####

# Git
function git_branch {
  # Shows the current branch if in a git repository
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\ \(\1\)/';
}

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
      echo "sls invoke local -f $1"
      sls invoke local -f $1
  else    
      echo "sls invoke local -f $1 --path $2"
      sls invoke local -f $1 --path $2
  fi
}

# Usefull
function random_element {
  declare -a array=("$@")
  r=$((RANDOM % ${#array[@]}))
  printf "%s\n" "${array[$r]}"
}

# Prompt
setEmoji () {
  EMOJI="$*"
  DISPLAY_DIR='$(dirs)'
  DISPLAY_BRANCH='$(git_branch)'
  PROMPT="${YELLOW}${DISPLAY_DIR}${GREEN}${DISPLAY_BRANCH}${RESET} ${EMOJI}"$'\n'"$ ";
}

newRandomEmoji () {
  setEmoji "$(random_element 😅 👽 🔥 🚀 👻 ⛄ 👾 🍔 😄 🍰 🐑 😎 🏎 🤖 😇 😼 💪 🦄 🥓 🌮 🎉 💯 ⚛️ 🐠 🐳 🐿 🥳 🤩 🤯 🤠 👨‍💻 🦸‍ 🧝‍ 🧞‍ 🧙‍ 👨‍🚀 👨‍🔬 🕺 🦁 🐶 🐵 🐻 🦊 🐙 🦎 🦖 🦕 🦍 🦈 🐊 🦂 🐍 🐢 🐘 🐉 🦚 ✨ ☄️ ⚡️ 💥 💫 🧬 🔮 ⚗️ 🎊 🔭 ⚪️ 🔱)"
}

alias jestify="PS1=\"🃏\"$'\n'\"$ \"";
alias testinglibify="PS1=\"🐙\"$'\n'\"$ \"";
alias cypressify="PS1=\"🌀\"$'\n'\"$ \"";
alias staticify="PS1=\"🚀\"$'\n'\"$ \"";
alias nodeify="PS1=\"💥\"$'\n'\"$ \"";
alias reactify="PS1=\"⚛️\"$'\n'\"$ \"";
alias harryify="PS1=\"🧙‍\"$'\n'\"$ \"";

# allow substitution in PS1
setopt promptsubst

# history size
HISTSIZE=5000
HISTFILESIZE=10000

SAVEHIST=5000
setopt EXTENDED_HISTORY
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
# share history across multiple zsh sessions
setopt SHARE_HISTORY
# append to history
setopt APPEND_HISTORY
# adds commands as they are typed, not at shell exit
setopt INC_APPEND_HISTORY
# do not store duplications
setopt HIST_IGNORE_DUPS

# PATH ALTERATIONS
## Node
PATH="/usr/local/bin:$PATH:./node_modules/.bin";

## Yarn
# PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
alias yarn="echo update the PATH in ~/.zshrc"

# Custom bins
PATH="$PATH:$HOME/.bin";
# dotfile bins
PATH="$PATH:$HOME/.my_bin";

# CDPATH ALTERATIONS
CDPATH=.:$HOME:$HOME/code:$HOME/code/epic-react:$HOME/code/testingjavascript:$HOME/Desktop
# CDPATH=($HOME $HOME/code $HOME/Desktop)

# disable https://scarf.sh/
SCARF_ANALYTICS=false

###### Alias #####

# VSCode
alias code="\"/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code\""
function c { code ${@:-.} }

# Move between directories
alias ..="cd ../";
alias ..l="cd ../ && ll";
alias de="cd ~/Desktop";
alias d="cd ~/code";

# List
alias ls="ls --color=yes"
alias lsl="ls -l --color=yes"
alias lsa="ls -a"
alias lsal="ls -al"
alias ll="ls -1a";

# Zshrc
alias vz="vim ~/.zshrc";
alias cz="code ~/.zshrc";

# BASH
alias sz="source ~/.zshrc";
alias reload=". .zshrc"

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

# Custom functions
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

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin" 

###### LOADING FILES #####
source $HOME/.nvm/nvm.sh
source $HOME/z.sh
