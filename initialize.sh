#!/usr/bin/env bash

# Move files
cd "$(dirname "${BASH_SOURCE}")";

function doIt() {
  rsync --exclude ".git/" \
  --exclude ".DS_Store" \
  --exclude ".osx" \
  --exclude "initialize.sh" \
  --exclude "update.sh" \
  --exclude "README.md" \
  --exclude "LICENSE-MIT.txt" \
  --exclude ".macos" \
  --exclude ".macos_personal" \
  --exclude "Brewfiles/" \
  --exclude ".atom/.my_atom_packages" \
  -avh --no-perms . ~;
  source ~/.bash_profile;

  # Check if Homebrew is installed
  which -s brew
  if [[ $? != 0 ]] ; then
    # Install Homebrew
    # https://github.com/mxcl/homebrew/wiki/installation
    /usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/gist/323731)";
    # Run brewfile
    # Install new bash and other things
    brew bundle --file=Brewfiles/BrewFileUniversal;
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
      brew bundle --file=Brewfiles/BrewFilePersonal;
      if [ -f ".macos_personal"]; then
        bash .macos_personal; #Computername
      fi;
    fi;
    echo "updating mac os settings";
    bash .macos;
  else
    # Make sure we’re using the latest Homebrew.
    brew update;
    # Upgrade any already-installed formulae.
    brew upgrade;
    # Remove unused files
    brew cleanup;
    # Update all atom packages
    apm upgrade;
  fi
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
  doIt;
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt;
  fi;
fi;
unset doIt;
