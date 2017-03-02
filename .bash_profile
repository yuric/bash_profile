export PATH="/usr/local/bin:$PATH"
PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

RED="\033[0;31m"
YELLOW="\033[0;33m"
GREEN="\033[0;32m"
CYAN="\033[0;36m"
NO_COLOUR="\[\033[0m\]"

parse_git_branch ()
{
    local GITDIR=`git rev-parse --show-toplevel 2>&1` # Get root directory of git repo
    if [[ "$GITDIR" != '/Users/shreyas' ]] # Don't show status of home directory repo
    then
        # Figure out the current branch, wrap in brackets and return it
        local BRANCH=`git branch 2>/dev/null | sed -n '/^\*/s/^\* //p'`
        if [ -n "$BRANCH" ]; then
            echo -e "[$BRANCH]"
        fi
    else
        echo ""
    fi
}

function git_color ()
{
    # Get the status of the repo and chose a color accordingly
    local STATUS=`git status 2>&1`
    if [[ "$STATUS" == *'Not a git repository'* ]]
    then
        echo ""
    else
        if [[ "$STATUS" != *'working directory clean'* ]]
        then
            # CYAN is if need to commit
            echo -e "$CYAN"
        else
            if [[ "$STATUS" == *'Your branch is ahead'* ]]
            then
                # yellow if need to push
                echo -e "$YELLOW"
            else
                # else cyan
                echo -e "$GREEN"
            fi
        fi
    fi
}

#http://shreyaschand.com/blog/2013/03/18/show-git-branch-status-in-bash-prompt/
# Call the above functions inside the PS1 declaration
#export PS1='$(git_color)$(parse_git_branch)\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \$ '
#https://gist.github.com/ekampf/772597/raw/19d3454aa3806a7131e0a2b01f12850e13f61f92/gistfile1.eclass
export PS1="$GREEN[\t]$NO_COLOUR\u@ISS:\w\$(git_color)\$(parse_git_branch)$NO_COLOUR\$ "
