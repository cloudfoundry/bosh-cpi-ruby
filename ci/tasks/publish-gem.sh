#!/usr/bin/env bash

set -e

: ${RUBYGEMS_API_KEY:?}

version="$( cat version-semver/version )"

cat << EOF > ~/.gem/credentials
---
:rubygems_api_key: ${RUBYGEMS_API_KEY}
EOF
chmod 0600 ~/.gem/credentials

pushd bosh-cpi-ruby-gem
  git clean -xfd
  echo "${version}" > version
  gem build *.gemspec
  gem push bosh_cpi-*.gem
popd
