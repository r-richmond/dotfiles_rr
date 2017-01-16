#!/usr/bin/env bash

#Make sure we can use aliases
shopt -s expand_aliases
source ~/.bash_profile

# Move files
# cd "$(dirname "${BASH_SOURCE}")";
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function doIt() {
  echo "updating atom config files"
  rsync ~/.atom/config.cson "$DIR"/.atom
  rsync ~/.atom/init.coffee "$DIR"/.atom
  rsync ~/.atom/keymap.cson "$DIR"/.atom
  rsync ~/.atom/snippets.cson "$DIR"/.atom
  rsync ~/.atom/styles.less "$DIR"/.atom
  echo  "updating atom package list"
  list_atom_packages > atom/.my_atom_packages
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
  doIt;
else
  read -p "This may overwrite existing files in your dot files repo. Are you sure? (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
  doIt;
  fi;
fi;
unset doIt;
