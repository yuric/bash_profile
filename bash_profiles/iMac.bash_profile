#Creator: Yuri Costa
#Contributors: 
#June.2017
#github.com/yuric/bash_profile, 
#This code is released under the AGPLv3 license.
#Thank you for persisting unmodified references and text above this line. 
#Reach out if you have questions/comments.

echo "....logged in as $USER at $(hostname) and loading ~/.bash_profile......."

export PATH="/usr/local/bin:$PATH"
PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin
PROMPT_COMMAND='PS1="${NO_COLOUR}[\t]\w$(py_env_and_stash)$(rvm_env_set)$(git_prompt):$ "'
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
source ~/.profile

# Load git completions
git_completion_script=/usr/local/etc/bash_completion.d/git-completion.bash
test -s $git_completion_script && source $git_completion_script

# A more colorful prompt
c_reset='\[\e[0m\]'
c_git_clean='\[\e[0;32m\]'
c_git_dirty='\[\e[0;31m\]'

RED="\033[0;31m"
YELLOW="\033[0;33m"
GREEN="\033[0;32m"
CYAN="\033[0;36m"
NO_COLOUR="\[\033[0m\]"
DIM="\e[2m"


export PROMPT_COMMAND # Force grep to always use the color option and show line numbers
export GREP_OPTIONS='--color=always'
export LSCOLORS=ExGxFxdxCxDxDxaccxaeex
alias boot="source ~/.bash_profile"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias ls="ls -Gh -a -l -p"
alias run='python manage.py runserver_plus'
alias pcollect="python manage.py collectstatic"
alias pdb="python manage.py dbshell"
alias pmigrate="python manage.py migrate"
alias ptest="python manage.py test"
alias remove='rm -i'
alias move='mv -i'
# alias envp="bash -c \"set -o posix; set | sed -e '/^_/,\\\$d';\""
#alias env="set -o posix ; set)
alias lsd="du -cksh * |sort -rn |head -11  | ls -Gh -a -l -p"

#exposes rvm virtual virtual env name
rvm_env_set ()
{
  rvm_env=`rvm-prompt i v p g`
  echo " ${DIM}${rvm_env}${c_reset}" #  #echo "${DIM}${rvm_env:0:1}${rvm_env:3:1}-${rvm_env: -3}"
}

#exposes python virtual virtual env name
python_env ()
{
  venv="${VIRTUAL_ENV##*/}"
  full=" ${DIM}${venv:0:1}${venv:3:1}-${venv: -3}"
  noise=7
  if [ ${#full} -gt $noise ]
  then
    echo $full
  else
    echo "${DIM}"
  fi
}

# Gets python virtual env and "|shashed:N". N is the number of stashed states (if any).
py_env_and_stash ()
{
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    return 0
  fi
  #determine "|shashed:N"
  stash=`expr $(git stash list 2>/dev/null| wc -l)`
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