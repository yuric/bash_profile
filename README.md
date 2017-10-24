### .bash_profile

I would love ideas on what good stuff is missing and help making what is already in Master.bash_profile better. Know need:
 1. add git_completion_script file to this repo. [a]
 2. remove comments debris
 3. all files have copy with credits and license ref. Use github.com/bevry/projectz instead. [b]
 * [du -cksh * |sort -rn |head -11] 

### direction

Eventually all the dev/productivity tools I use will be setup and configured via a some shell script in the repo. 

#####other cool tools I am want to learn more about or add to .bash_profile in no particular order
* [gitignore.io](https://github.com/joeblau/gitignore.io)
* [projectz](github.com/bevry/projectz)
* [rails composer](https://github.com/RailsApps/rails-composer)(might not work with latest rails)
* textmate => shell support[preferences->terminal] export EDITOR="/usr/local/bin/mate -w" -> .bash_profile_
  * https://github.com/chriskempson/base16-textmate
  * customized .tm_properties has good info
  * TM_RUBY=#{which ruby's path}
Show hidden files:
* defaults write com.apple.finder AppleShowAllFiles YES
List view as default:∏
* defaults write com.apple.Finder FXPreferredViewStyle Nlsv;killall Finder
* https://goo.gl/4w5Ngd // https://goo.gl/3w1ose
### notes

[a] Loads and tests it.
```bash
git_completion_script=/usr/local/etc/bash_completion.d/git-completion.bash
test -s $git_completion_script && source $git_completion_script

```

[b] This might end up getting trimmed but this it is good oportunity to see [Projectz](github.com/bevry/projectz) in action.
```bash
#Creator: Yuri Costa
#Contributors: 
#June.2017
#github.com/yuric/bash_profile, 
#This code is released under the AGPLv3 license.
#Thank you for persisting unmodified references and text above this line. 
#Reach out if you have questions/comments.
```

###


Thanks for stopping by. :blush:
ln -s /Users/yuricosta/Documents/developer/YuriC/bash_profile/Master.bash_profile ~/.bash_profile