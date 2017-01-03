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

version="$( cat version-semver/version )"

check_param RUBY_VERSION

source /etc/profile.d/chruby.sh
chruby $RUBY_VERSION

pushd bosh-src
    git clean -xfd
    echo "${version}" > version
    gem build *.gemspec
    gem push bosh_cpi-*.gem
popd