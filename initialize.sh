#!/usr/bin/env bash

# Move files
cd "$(dirname "${BASH_SOURCE[0]}")" || exit;

function doIt() {
  rsync --exclude ".git/" \
  --exclude ".DS_Store" \
  --exclude "initialize.sh" \
  --exclude "update.sh" \
  --exclude "Linux/" \
  --exclude "README.md" \
  --exclude "LICENSE-MIT.txt" \
  --exclude "setup_files/" \
  --exclude "misc_notes/" \
  --exclude ".atom/.my_atom_packages" \
  -avh --no-perms . ~;

  # shellcheck source=/dev/null
  source ~/.bash_profile

  # Check if Homebrew is installed
  which -s brew
  if [[ $? != 0 ]] ; then
    echo "no brew found; running as new install";
    # Install Homebrew
    # https://github.com/mxcl/homebrew/wiki/installation
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
    # Install new bash and other things
    brew bundle --file=brewfiles/universal.brewfile;
    brew install homebrew/versions/bash-completion2;
    # Switch to using brew-installed bash as default shell
    if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
      # Add the new shell to the list of allowed shells
      echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
      # Change to the new shell
      chsh -s /usr/local/bin/bash;
    fi;
    # Install Atom Packages
    # http://evanhahn.com/atom-apm-install-list/
    apm install --packages-file .atom/.my_atom_packages;
    # update mac settings
    read -p "Run Personal Scripts? (y/n) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      brew bundle --file=brewfiles/personal.brewfile;
      if [ -f ".setup_files/personal.macos" ]; then
        bash .setup_files/personal.macos; #Computername
      fi;
    fi;
    echo "updating mac os settings";
    bash .setup_files/universal.macos;
  else
    echo "brew found; running as update not new install";
  fi;

  echo "assigning crontab";
  crontab ~/crontab/crontab;
  for file in ~/crontab/scripts/*; do
    chmod +x "$file";
  done;
  unset file;

  # run this if exists | Alternative to git credentials in .extras
  [ -r ~/update_gitconfig.sh ] && [ -f ~/update_gitconfig.sh ] && bash ~/update_gitconfig.sh;
}

if [ "$1" == "--force" ] || [ "$1" == "-f" ]; then
  doIt;
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt;
  fi;
fi;
unset doIt;
