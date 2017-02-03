#!/usr/bin/env bash

read -p "Update gitconfig Personal (p) Work (w) " -n 1;
echo "";
if [[ $REPLY =~ ^[Ww]$ ]]; then
  git config --global user.name "Your Name";
  git config --global user.email "Work Email";
  echo "Switched to Work"
elif [[ $REPLY =~ ^[Pp]$ ]]; then
  git config --global user.name "github user name";
  git config --global user.email "github email";
  echo "Switched to Personal"
else
  echo "You did nothing";
fi;
