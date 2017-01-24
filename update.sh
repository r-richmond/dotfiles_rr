#!/usr/bin/env bash

#Make sure we can use aliases
shopt -s expand_aliases;
# in case no file in folder
shopt -s nullglob;
# shellcheck source=/dev/null
source ~/.bash_profile

# Move files
# cd "$(dirname "${BASH_SOURCE}")";
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function doIt() {
  which -s atom
  if [[ $? = 0 ]] ; then
    # pull in atom config files from ~/.atom/
    for file in ~/.atom/{config.cson,init.coffee,keymap.cson,snippets.cson,styles.less}; do
      [ -r "$file" ] && [ -f "$file" ] && rsync -ciah "$file" "$DIR"/.atom/
    done;
    unset file;
    list_atom_packages > .atom/.my_atom_packages
  fi;

  # pull in dotfiles from ~/.dotfiles/
  for file in ~/.dotfiles/.[^.]*; do
    if [[ "$file" == */.extra ]]; then
      continue; # don't sync .extra it isn't tracked
    fi;
    [ -r "$file" ] && [ -f "$file" ] && rsync -ciah "$file" "$DIR"/.dotfiles/
  done;
  unset file;

  # pull in dotfiles from ~/
  for file in ~/.{bash_profile,bashrc,gitignore,inputrc,nanorc}; do
    [ -r "$file" ] && [ -f "$file" ] && rsync -ciah "$file" "$DIR"/
  done;
  unset file;

  # pull in nanorc language files from ~/.nano/
  for file in ~/.nano/*.nanorc; do
    [ -r "$file" ] && [ -f "$file" ] && rsync -ciah "$file" "$DIR"/.nano/
  done;

  # pull in dbeaver configs that exist in repo if exist in ~
  for file in ./.dbeaver/.metadata/.plugins/org.eclipse.core.runtime/.settings/*.prefs; do
    file_name="$(basename $file)"
    [ -r ~/.dbeaver/.metadata/.plugins/org.eclipse.core.runtime/.settings/"$file_name" ] && \
    [ -f ~/.dbeaver/.metadata/.plugins/org.eclipse.core.runtime/.settings/"$file_name" ] && \
    rsync -ciah ~/.dbeaver/.metadata/.plugins/org.eclipse.core.runtime/.settings/"$file_name" \
    "$DIR"/.dbeaver/.metadata/.plugins/org.eclipse.core.runtime/.settings/
  done;

  echo "updates finished review local repo for changes"
  unset file;
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
