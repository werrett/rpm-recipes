#!/usr/bin/env bash

# Install FPM Cookery and its prerequisites. Tested on Centos 7.

# Ruby version to bootsrap via Rbenv
RUBY_VERSION="2.3.0"

yum groupinstall 'Development Tools' -y
yum install git zlib zlib-devel openssl openssl-devel readline readline-devel -y

# Bootstrap a Ruby environment wit Rbenv
# Ironically, Rbenv needs manuall installation so we can build RPMs for it
# Install instructions from https://github.com/rbenv/rbenv#installation
git clone https://github.com/rbenv/rbenv.git "${HOME}/.rbenv"
cd "${HOME}/.rbenv" && src/configure && make -C src

# Hook RBENV into bash env
cat <<EOF>>"${HOME}/.bash_profile"

# Rbenv configuration
export PATH="\$HOME/.rbenv/bin:\$PATH"
if which rbenv > /dev/null; then eval "\$(rbenv init -)"; fi
EOF

# Install the ruby-build Rbenv plugin
#Install instructions from https://github.com/rbenv/ruby-build#readme
git clone https://github.com/rbenv/ruby-build.git \
  "${HOME}/.rbenv/plugins/ruby-build"

source "${HOME}/.bash_profile"

# Init Rbenv and install Ruby
rbenv install ${RUBY_VERSION}
rbenv global ${RUBY_VERSION}
rbenv rehash

# Set basic gem config to speed up installs
cat <<EOF>"${HOME}/.gemrc"
# Gem Config - Don't install docs by default
gem: --no-ri --no-rdoc
EOF

# FIXME: Install Puppet as well to address the FPM error:
# "Unable to load Puppet. Automatic dependency installation disabled"

# Install fpm-cookery
gem install fpm-cookery
