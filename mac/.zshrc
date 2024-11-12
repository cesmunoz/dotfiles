# PROMPT
PROMPT='%F{green}[%*]%f %F{blue}%~%f $ICON_PROMPT '

# Directories
alias ..="cd ../";
alias ...="cd ../../";
alias ....="cd ../../../";

# FileSystem
alias lsa="ls -a";
alias ff="fzf";

# Tools
alias g="git";
alias n="nvim";
alias lz="lazygit";
alias vim="n";
alias v="n";
alias c="code";

# Dotfiles
alias nz="n ~/.zshrc";
alias cz="c ~/.zshrc";
alias cg="c ~/.gitconfig";
alias ng="n ~/.gitconfig";
alias ninit="n ~/.config/nvim/init.lua";

# Misc
alias reload="source ~/.zshrc"

# Git
alias gs="git status -s"
alias ga="git add -A"
alias gf="git fetch"
alias gc="git commit -m"
alias gsw="git switch"
alias gswc="git switch -c"
alias gpo='git push origin "$(git symbolic-ref --short HEAD)"'
alias gponv='git push origin "$(git symbolic-ref --short HEAD)" --no-verify'

## AWS
alias awswhoami="aws sts get-caller-identity";

###### CUSTOM FUNCTIONS ######

# Aws
function workenv() {
  echo "Change AWS Working environment to > $1"
  export AWS_PROFILE=$1
}

alias workenvwork="workenv fs-dev";
alias fsnd="workenvwork && ./bin/start-no-docker";
alias fswd="workenvwork && ./bin/start-docker";

