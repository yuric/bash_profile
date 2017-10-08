#Creator: Yuri Costa
#Contributors: 
#June.2017
#github.com/yuric/bash_profile, 
#This code is released under the AGPLv3 license.
#Thank you for persisting unmodified references and text above this line. 
#Reach out if you have questions/comments.

echo "==============Loading ~/.bash_profile as $USER at $(hostname)"
export SLS_DEBUG=*
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Development
export ZAPPA_DEPLOY=update
export DEPLOY_STAGE=staging
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
export AWS_DEFAULT_REGION=us-west-2
export AWS_ACCESS_KEY_ID_S3=
export AWS_SECRET_ACCESS_KEY_S3=
export AWS_STORAGE_BUCKET_NAME=
export SECRET_KEY=
export LRS_DB_NAME=lrs
export LRS_DB_USER=lrs
export TEST_LRS_DB_NAME=
export LRS_DB_PASSWORD=
export LRS_DB_HOST=
export TEST_LRS_DB_HOST=
export SITE_URL=
# export CLOUDMPQ_USER=
# export CLOUDMPQ_PASSWORD=
# export CLOUDMPQ_HOST=
# export CLOUDMPQ_VHOST=
# export CLOUDMPQ_VHOST_TEST=
export SECRET_KEY=
export TEST_AMPQ_USERNAME=
export TEST_AMPQ_PASSWORD=
export TEST_AMPQ_HOST=
export TEST_AMPQ_VHOST=
export SQS_HOST=
export TEST_SQS_HOST=s
export LRS_DEBUG=True
export TWILIO_ACC_SID=COOL_SID=
export TWILIO_AUTH_TOKEN=COOL_TOKEN=
#export GEM_HOME="/Users/ycosta3987/.rvm/gems/ruby-2.4.1@canvas"

source /usr/local/bin/virtualenvwrapper.sh
source "$rvm_path/contrib/ps1_functions"

export PATH="/usr/local/bin:$PATH"
PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.6/bin
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile"

source ~/.profile


# Load git completions
git_completion_script=/usr/local/etc/bash_completion.d/git-completion.bash
test -s $git_completion_script && source $git_completion_script

# A more colorful prompt
# \[\e[0m\] resets the color to default color
c_reset='\[\e[0m\]'
# \e[0;32m\ sets the color to green
c_git_clean='\[\e[0;32m\]'
# \e[0;31m\ sets the color to red
c_git_dirty='\[\e[0;31m\]'

RED="\033[0;31m"
YELLOW="\033[0;33m"
GREEN="\033[0;32m"
CYAN="\033[0;36m"
NO_COLOUR="\[\033[0m\]"
DIM="\e[2m"
#RESET_DIM="\e[22m"
# PS1 is the variable for the prompt you see everytime you hit enter
#PS1="[${NO_COLOUR}\t]\w${c_reset}$(git_prompt)$(python_env):$"
PROMPT_COMMAND='PS1="${NO_COLOUR}[\t]\w$(py_env_and_stash)$(rvm_env_set)$(git_prompt):$ "'

export PROMPT_COMMAND
# Force grep to always use the color option and show line numbers
export GREP_OPTIONS='--color=always'

#exposes python virtual virtual env name
python_env ()
{
  venv="${VIRTUAL_ENV##*/}"
  echo " ${DIM}${venv:0:1}${venv:3:1}-${venv: -3}"
}

#exposes python virtual virtual env name
rvm_env_set ()
{
  rvm_env=`rvm-prompt i v p g`
  #echo " ${DIM}${rvm_env:0:1}${rvm_env:3:1}-${rvm_env: -3}"
  echo " ${DIM}${rvm_env}${c_reset}"
}

# Returns python virtual env and "|shashed:N" where N is the number of stashed states (if any).
py_env_and_stash ()
{
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    return 0
  fi
  #determine "|shashed:N" where N is the number of stashed states (if any).
  stash=`expr $(git stash list 2>/dev/null| wc -l)`
  #determine Python vertual env if vailable
  py_env=$(python_env)
  if [ "$stash" != "0" ]
  then
    echo "$py_env|stashed:$stash${c_reset}"
  else
    echo "$py_env${c_reset}"
  fi

}

# determines if the git branch is clean or dirty
git_prompt ()
{
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    return 0
  fi

  # Grab working branch name
  git_branch=$(Git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
  #grab stashes if any
  untracked_files=`expr $(git ls-files --others --exclude-standard 2>/dev/null| wc -l)`

  # determines if the git branch has untracked files not on .gitignore
  if [ "$untracked_files" != "0" ]
  then
    git_color=${RED}
    uc="@untracked:$untracked_files"
  fi
  # Clean or dirty branch
  if git diff --quiet 2>/dev/null >&2; then
    git_color="${c_git_clean}"
  else
    git_color=${CYAN}
  fi

  echo "[$git_color$git_branch$uc${c_reset}]"
}

# search for LSCOLORS
export LSCOLORS=ExGxFxdxCxDxDxaccxaeex
# Force ls to use colors (G) and use humanized file sizes (h)
alias ls="ls -Gh -a -l -p"
alias run='python manage.py runserver_plus'
alias pcollect="python manage.py collectstatic"
alias pdb="python manage.py dbshell"
alias pmigrate="python manage.py migrate"
alias ptest="python manage.py test"
alias boot="source ~/.bash_profile"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias envp="bash -c \"set -o posix; set | sed -e '/^_/,\\\$d';\""
alias lrs="cd Documents/Developer/ADL_LRS"
alias remove='rm -i'
alias move='mv -i'
#alias env="set -o posix ; set)
#du -cksh * |sort -rn |head -11 
	# Overwritting so python .envs are loaded when entering directory. profile_settings.bash is in the github directory (yuric/bash_profile)
# cd () { builtin cd "$@" && chpwd; }
# pushd () { builtin pushd "$@" && chpwd; }
# popd () { builtin popd "$@" && chpwd; }
#
# chpwd () {
# echo $PWD
#   case $PWD in
#     /Users/ycosta3987/Documents/Developer/ADL_LRS)
#         . project_settings.bash;;
#   esac
# }

# Added by the canvas-lms setup script
# These settings make chruby work
# See https://github.com/postmodern/chruby
[ -f /usr/local/share/chruby/chruby.sh ] && . /usr/local/share/chruby/chruby.sh
[ -f /usr/local/share/chruby/auto.sh ] && . /usr/local/share/chruby/auto.sh
[ -f /usr/local/opt/chruby/share/chruby/chruby.sh ] && . /usr/local/opt/chruby/share/chruby/chruby.sh
[ -f /usr/local/opt/chruby/share/chruby/auto.sh ] && . /usr/local/opt/chruby/share/chruby/auto.sh

#Added by canvas-lms setup-development script
#This adds the gem bin to your PATH
# if ! $(echo $PATH | grep "$(gem env 'GEM_PATHS' | sed -e 's|:|/bin:|g')/bin" >/dev/null 2>&1); then
#     export PATH="$PATH:$(gem env 'GEM_PATHS' | sed -e 's|:|/bin:|g')/bin"
# fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# # Added by canvas-lms setup-development script
# # This adds the brew bin to your PATH
# if $(which brew >/dev/null 2>&1); then
#     export PATH="$PATH:$(brew --prefix)/bin"
# fi
#
# # Added by canvas-lms setup-development script
# # This adds the gem bin to your PATH
# if ! $(echo $PATH | grep "$(gem env 'GEM_PATHS' | sed -e 's|:|/bin:|g')/bin" >/dev/null 2>&1); then
#     export PATH="$PATH:$(gem env 'GEM_PATHS' | sed -e 's|:|/bin:|g')/bin"
# fi
#
# # Added by canvas-lms setup-development script
# # This adds the gem bin to your PATH
# if ! $(echo $PATH | grep "$(gem env 'GEM_PATHS' | sed -e 's|:|/bin:|g')/bin" >/dev/null 2>&1); then
#     export PATH="$PATH:$(gem env 'GEM_PATHS' | sed -e 's|:|/bin:|g')/bin"
# fi
hitch() {
  command hitch "$@"
  if [[ -s "$HOME/.hitch_export_authors" ]] ; then source "$HOME/.hitch_export_authors" ; fi
}
alias unhitch='hitch -u'
hitch
