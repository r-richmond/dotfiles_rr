#!/usr/bin/env bash

echo -e ${PATH//:/\\n};

brew update;
brew upgrade;
brew cleanup;

apm update;

#https://github.com/mathiasbynens/dotfiles/blob/master/.aliases alias lscleanup
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder;

echo "`date` "$'\n'>> ~/Desktop/firedlog.md;
