#!/usr/bin/env bash

# Move files
cd "$(dirname "${BASH_SOURCE[0]}")" || exit;

function doIt() {
  # Update submodles
  git submodule update --init --recursive;

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

  # Check if Homebrew is installed
  which -s brew
  if [[ $? != 0 ]] || [ "$FORCENEW" == 1 ] ; then
    echo "no brew found; running as new install";
    # Install Homebrew
    # https://github.com/mxcl/homebrew/wiki/installation
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
    # Turn off brew analytics
    brew analytics off;
    # Install new bash and other things
    brew bundle --file=setup_files/universal.brewfile;
    # Accept license
    sudo xcodebuild -license accept;
    read -p "Did you accept the license? (y/n) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      echo "xcode license accepted"
    else
      echo "you didn't accept the license"
      return 1
    fi;
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
      brew bundle --file=setup_files/personal.brewfile;
      if [ -f "setup_files/personal.macos" ]; then
        bash setup_files/personal.macos; #Computername
      fi;
    fi;
    echo "updating mac os settings";
    # enable dark mode from brew
    dark-mode on;
    bash setup_files/universal.macos;

    echo "Configuring Python Make Sure python is first in Path";
    pip3 install -q --upgrade pip;
    pip3 install -q --upgrade setuptools;
    [ ! -d ~/python_virtual_envs ] && mkdir ~/python_virtual_envs;
    pip3 install -q flake8;
    pip3 install -q black;

    [ ! -d ~/Dropbox ] && mkdir ~/Dropbox;
    [ ! -d ~/Dropbox/python ] && mkdir ~/Dropbox/python;

    echo "Configuring autocomplete Docker";
    [ -d /usr/local/etc/bash_completion.d ] && cd /usr/local/etc/bash_completion.d || exit;
    [ ! -f docker.bash-completion ] && ln -s /Applications/Docker.app/Contents/Resources/etc/docker.bash-completion;
    [ ! -f docker-machine.bash-completion ] && ln -s /Applications/Docker.app/Contents/Resources/etc/docker-machine.bash-completion;
    [ ! -f docker-compose.bash-completion ] && ln -s /Applications/Docker.app/Contents/Resources/etc/docker-compose.bash-completion;
  else
    echo "brew found; running as update not new install";
  fi;

  echo "sourcing bash_profile";
  # shellcheck source=/dev/null
  source ~/.bash_profile;

  echo "assigning crontab";
  crontab ~/crontab/crontab;
  for file in ~/crontab/scripts/*; do
    chmod +x "$file";
  done;
  unset file;

  # run this if exists | Alternative to git credentials in .extras
  [ -r ~/update_gitconfig.sh ] && [ -f ~/update_gitconfig.sh ] && bash ~/update_gitconfig.sh;
}

if [ "$1" == "--force-new" ] || [ "$2" == "--force-new" ]; then
  FORCENEW=1
fi;

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
