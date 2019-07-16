# set path:
# check presence of Haskell binary directory and if so add it to the PATH
[ -d "$HOME/Library/Haskell/bin" ] && export PATH="$HOME/Library/Haskell/bin:$PATH";
# check presence of mysql binary directory and if so add it to the PATH
[ -d "/usr/local/mysql/bin" ] && export PATH="/usr/local/mysql/bin:$PATH";
# check presence of a $HOME/bin and if so add it to the PATH
[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH";
# check presence of postgres app and add it to the path if it exists
[ -d "/Applications/Postgres.app" ] && export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH";
# check presence of brew grep and add to path if it exists
[ -d "/usr/local/opt/grep/libexec/gnubin" ] && export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH";
# check presence of brew gnu-sed and add to path if it exists
[ -d "/usr/local/opt/gnu-sed/libexec/gnubin" ] && export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH";
# remove duplicates from the path
export PATH=`awk -F: '{for(i=1;i<=NF;i++){if(!($i in a)){a[$i];printf s$i;s=":"}}}'<<<$PATH`;

# incase no dot files
shopt -s nullglob;

for file in ~/.dotfiles-bash/.[^.]*; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Save multi-line commands as one command
shopt -s cmdhist;

# Add tab completion for many Bash commands
if which brew &> /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
  source "$(brew --prefix)/share/bash-completion/bash_completion";
  # Temporary fix
  for file in "$(brew --prefix)/etc/bash_completion.d/"*; do
    source "$file";
  done;
elif [ -f /etc/bash_completion ]; then
  source /etc/bash_completion;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;
