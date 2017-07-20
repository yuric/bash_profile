#!/bin/bash
#With the bash it can load a python env for you. Use that bash setting and this very much with caution and at your own risk.
c_reset="\e[0m"
GREEN="\033[0;32m"
local_python_env ()
{
  vpy="${VIRTUAL_ENV##*/}"
  echo "${vpy:0:1}${vpy:3:1}-${vpy: -3}"
}
local_py=$(local_python_env)
source "../env/bin/activate"
echo -e "============Python env activated ${GREEN}[$local_py]$(tput sgr0) for ADL_LRS"
