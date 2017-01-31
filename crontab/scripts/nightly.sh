#!/usr/bin/env bash

echo -e ${PATH//:/\\n};

PATH=/usr/local/bin:$PATH

brew update;
brew upgrade;
brew cleanup;

apm update --confirm false;

#https://github.com/mathiasbynens/dotfiles/blob/master/.aliases alias lscleanup
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder;

echo "`date` "$'\n'>> ~/Desktop/firedlog.md;
