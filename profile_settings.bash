#!/bin/bash
#Creator: Yuri Costa
#Contributors: 
#June.2017
#github.com/yuric/bash_profile, 
#This code is released under the AGPLv3 license.
#Thank you for persisting unmodified references and text above this line. 
#Reach out if you have questions/comments.

#Used to load python env when in project directory. Relevant executed code and overwrite in .bash_profile.
#Use that bash setting and this very much with caution and at your own risk.
c_reset="\e[0m"
GREEN="\033[0;32m"
local_python_env ()
{
  vpy="${VIRTUAL_ENV##*/}"
  echo "${vpy:0:1}${vpy:3:1}-${vpy: -3}"
}
source "../env/bin/activate"
local_py=$(local_python_env)
echo -e "============Python env activated ${GREEN}[$local_py]$(tput sgr0) for ADL_LRS"


