#!/usr/bin/env bash

set -e

check_param() {
  local name=$1
  local value=$(eval echo '$'$name)
  if [ "$value" == 'replace-me' ]; then
    echo "environment variable $name must be set"
    exit 1
  fi
}

print_git_state() {
  if [ -d ".git" ] ; then
    echo "--> last commit..."
    TERM=xterm-256color git --no-pager log -1
    echo "---"
    echo "--> local changes (e.g., from 'fly execute')..."
    TERM=xterm-256color git --no-pager status --verbose
    echo "---"
  fi
}

check_param RUBY_VERSION

source /etc/profile.d/chruby.sh
chruby $RUBY_VERSION

cd bosh-src
print_git_state

export PATH=/usr/local/ruby/bin:$PATH
bundle install --local
bundle exec rspec spec
