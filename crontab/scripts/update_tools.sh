#!/usr/bin/env bash

echo -e ${PATH//:/\\n};

PATH=/usr/local/bin:$PATH

brew update;
brew upgrade;
brew cleanup;

apm update --confirm false;

echo "`date` "$'\n'>> ~/Desktop/firedlog.md;
