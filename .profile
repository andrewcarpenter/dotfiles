# detect interactive shell
case "$-" in
    *i*) INTERACTIVE=yes ;;
    *)   unset INTERACTIVE ;;
esac

# detect login shell
case "$0" in
    -*) LOGIN=yes ;;
    *)  unset LOGIN ;;
esac


# ENVIRONMENTAL VARIABLES
PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"
PATH="/usr/local/bin:$PATH"
test -d "$HOME/bin" && PATH="$HOME/bin:$PATH"
test -d "$HOME/Developer/bin" && PATH="$HOME/Developer/bin:$PATH"
export MANPATH="/usr/local/man:$MANPATH"
export GEM_OPEN_EDITOR="mvim"
export BUNDLER_EDITOR="mvim"
export EDITOR="mvim"
export RAILS_ENV="development"
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# TAB COMPLETION
complete -C ~/.bash/rake_completion.rb -o default rake
complete -C ~/.bash/cap_completion.rb -o default cap

complete -C ~/.bash/ssh_completion.rb -o default ssh
complete -C ~/.bash/app_completion.rb -o default app
complete -C ~/.bash/gem_completion.rb -o default gem

source      ~/.bash/git-completion.bash


# BASH HISTORY
# export HISTTIMEFORMAT="%h/%d - %H:%M:%S "
export HISTSIZE=5000

# PROMPT
source ~/.bash/prompt.bash

# `app` function
source ~/.bash/app.bash

# ALIASES
alias realias='$EDITOR ~/.aliases; source ~/.aliases'
source ~/.aliases

# MISC
source ~/.bash/misc.bash

test -n "$INTERACTIVE" -a -n "$LOGIN" && {
    uname -npsr
    uptime
}

# Load RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
