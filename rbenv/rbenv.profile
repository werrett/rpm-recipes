# Rbenv setup - only add RBENV PATH variables if no single user install found
if [[ ! -d "${HOME}/.rbenv" ]]; then
 export RBENV_ROOT=/usr/share/rbenv
 export PATH="$RBENV_ROOT/bin:$PATH"
 eval "$(rbenv init -)"
fi
