#!/usr/bin/env bash

set -e

pushd bosh-cpi-ruby-gem
  bundle
  bundle exec rspec spec
popd
