#!/usr/bin/env bash

#Make sure we can use aliases
shopt -s expand_aliases;
# in case no file in folder
shopt -s nullglob;
# shellcheck source=/dev/null
source ~/.bash_profile;

# Move files
# cd "$(dirname "${BASH_SOURCE}")";
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";

function doIt() {
  which -s atom
  if [[ $? = 0 ]] ; then
    # pull in atom config files from ~/.atom/
    for file in ~/.atom/{config.cson,init.coffee,keymap.cson,snippets.cson,styles.less}; do
      [ -r "$file" ] && [ -f "$file" ] && rsync -ciah "$file" "$DIR"/.atom/
    done;
    unset file;
    list_atom_packages > .atom/.my_atom_packages;
  fi;

  # pull in dbeaver configs that exist in repo if exist in ~
  for file in ./.dbeaver4/.metadata/.plugins/org.eclipse.core.runtime/.settings/*.prefs; do
    file_name="$(basename $file)"
    [ -r ~/.dbeaver4/.metadata/.plugins/org.eclipse.core.runtime/.settings/"$file_name" ] && \
    [ -f ~/.dbeaver4/.metadata/.plugins/org.eclipse.core.runtime/.settings/"$file_name" ] && \
    rsync -ciah ~/.dbeaver4/.metadata/.plugins/org.eclipse.core.runtime/.settings/"$file_name" \
    "$DIR"/.dbeaver4/.metadata/.plugins/org.eclipse.core.runtime/.settings/
  done;

  # pull in dotfiles from ~/.dotfiles-bash/
  for file in ~/.dotfiles-bash/.[^.]*; do
    if [[ "$file" == */.extra ]]; then
      continue; # don't sync .extra it isn't tracked
    fi;
    [ -r "$file" ] && [ -f "$file" ] && rsync -ciah "$file" "$DIR"/.dotfiles-bash/
  done;
  unset file;

  # pull in dotfiles from ~/
  for file in ~/.{bash_profile,bashrc,gitignore,inputrc,nanorc}; do
    [ -r "$file" ] && [ -f "$file" ] && rsync -ciah "$file" "$DIR"/
  done;
  unset file;

  # pull in python idle changes
  for file in ~/.idlerc/{config-highlight.cfg,config-main.cfg}; do
    [ -r "$file" ] && [ -f "$file" ] && rsync -ciah "$file" "$DIR"/.idlerc/
  done;
  unset file;

  # pull in nanorc language files from ~/.nano/
  for file in ~/.nano/*.nanorc; do
    [ -r "$file" ] && [ -f "$file" ] && rsync -ciah "$file" "$DIR"/.nano/
  done;

  # pull in pip config file
  for file in ~/Library/Application\ Support/pip/*.conf; do
    [ -r "$file" ] && [ -f "$file" ] && rsync -ciah "$file" "$DIR"/Library/Application\ Support/pip/
  done;

  # pull in psqlrc config file
  [ -r "$HOME/.psqlrc" ] && [ -f "$HOME/.psqlrc" ] && rsync -ciah "$HOME/.psqlrc" "$DIR""/.psqlrc"

  echo "updates finished review local repo for changes"
  unset file;
}

if [ "$1" == "--force" ] || [ "$1" == "-f" ]; then
  doIt;
else
  read -p "This will overwrite existing files in your dot files repo. Are you sure? (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
  doIt;
  fi;
fi;
unset doIt;
