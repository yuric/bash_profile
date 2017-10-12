#! /bin/bash
#Copyrite: Yuri Costa 
#Contributors: 
#Oct.2017
#github.com/yuric/bash_profile, 
#This code is released under the AGPLv3 license.
#Reach out if you have questions/comments yuri@sparkroad.com

# No Warranty, Usage at your own risk. Etc all the AGPLv3 license stuff.
# This script will build a full Github clone environment of github/user or github/organization public and private repos

# How-To
# 1. You will need an Auth Token to pull private as well: Get one here: https://github.com/settings/tokens
 #NOTE: A personal token will work for the a user or organization if the user that owns the token has read/clone/list access to the org's private repo.
# 2. Might require you to elavate right when running it: `sudo ./github-clone-all-on-tag.sh`
# 3. Run pullRepo.sh to pull latest code from Github.

echo -n "Enter GitHub Organization or User Tag (github/[tag]):"
read GitHubTag

echo -n "Enter Sub Directory to Create :"
read SubDirectory

echo -n "Enter Github (GH) Username :"
read Username

echo -n "Enter Github (GH) Password :"
read -s Password1

echo -n "Enter GH Auth token (github.com/settings/tokens) :"
read TokenGithub

echo " "
TypeOf=users
echo "Are you cloning a user's or organization's repos?"
echo "1 for personal (users)"
echo -n "2 for organization (AcmeGroup) :"
read InputTypeOf
case "$InputTypeOf" in
    1)
      TypeOf=users
      echo "Tag type set to users."
      ;;
    2)
      TypeOf=orgs
      echo "Tag type set to Organizations."
      ;;
    *)  
      echo "Not sure what you want. Defaulting to tag type users: "  $InputTypeOf
      ;;
esac

echo " "
# Confirm all is copacetic
echo "Tag : " $GitHubTag
echo "Directory : " $SubDirectory
echo "Username is : " $Username
echo "User or Org tag is : " $TypeOf
echo "Token: " $TokenGithub

echo " "
echo "Press Enter to confirm and continue.... [Control-C] to Terminate Script"

read GoDoIt
# Attempt to create $SubDirectory, if it already exists use it.
mkdir $SubDirectory

#GO! GO! GO!
curl --user "$Username:$Password1" -H "Authorization: token $TokenGithub" -s "https://api.github.com/$TypeOf/$GitHubTag/repos?per_page=100&page=1" | grep -e 'git_url' | cut -d \" -f 4 

curl --user "$Username:$Password1" -H "Authorization: token $TokenGithub" -s "https://api.github.com/$TypeOf/$GitHubTag/repos?per_page=100&page=1" | grep -e 'git_url*' | cut -d \" -f 4 | cut -d / -f 5 | cut -d . -f 1 | awk -v SubDirectory=$SubDirectory -v tag=$GitHubTag -v user=$Username '{print "/usr/bin/git clone ssh://git@github.com/" tag "/"  $1 ".git"}' >> $SubDirectory/cloneRepo.sh

curl --user "$Username:$Password1" -H "Authorization: token $TokenGithub" -s "https://api.github.com/$TypeOf/$GitHubTag/repos?per_page=100&page=1" | grep -e 'git_url*' | cut -d \" -f 4 | cut -d / -f 5 | cut -d . -f 1 | awk -v SubDirectory=$SubDirectory -v tag=$GitHubTag -v user=$Username '{print "cd ~/" SubDirectory "/" $1 "\n/usr/bin/git pull ssh://git@github.com/" tag "/"  $1 ".git\ncd ~"}' >>  $SubDirectory/pullRepo.sh

chmod 777 $SubDirectory/cloneRepo.sh
chmod 777 $SubDirectory/pullRepo.sh
echo " "
cd $SubDirectory
/bin/bash cloneRepo.sh

echo "All done!"