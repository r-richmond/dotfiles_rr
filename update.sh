#!/usr/bin/env bash

#Make sure we can use aliases
shopt -s expand_aliases;
# shellcheck source=/dev/null
source ~/.bash_profile

# Move files
# cd "$(dirname "${BASH_SOURCE}")";
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function doIt() {
  which -s atom
  if [[ $? = 0 ]] ; then
    #echo "updating atom config files"
    for file in ~/.atom/{config.cson,init.coffee,keymap.cson,snippets.cson,styles.less}; do
      [ -r "$file" ] && [ -f "$file" ] && rsync -ciah "$file" "$DIR"/.atom/
    done;
    #echo  "updating atom package list"
    list_atom_packages > .atom/.my_atom_packages
  fi;
  echo "updating dot files except .gitconfig"
  for file in ~/.{aliases,bash_profile,bash_prompt,bashrc,exports,extra,functions,gitignore,inputrc,nanorc}; do
    [ -r "$file" ] && [ -f "$file" ] && rsync -ciah "$file" "$DIR"/
  done;
  for file in ~/.nano/*.nanorc; do
    [ -r "$file" ] && [ -f "$file" ] && rsync -ciah "$file" "$DIR"/.nano/
  done;
  echo "updates finished review local repo for changes"
}

if [ "$1" == "--force" ] || [ "$1" == "-f" ]; then
  doIt;
else
  read -p "This may overwrite existing files in your dot files repo. Are you sure? (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
  doIt;
  fi;
fi;
unset doIt;
