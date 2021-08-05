#!/usr/bin/env bash

set -eu

fly -t bosh-ecosystem sp -p bosh-cpi-ruby \
  -c ci/pipeline.yml \
  -l <( lpass show --notes "bosh-cpi-ruby gem") \
  -l <( lpass show --notes pivotal-tracker-resource-keys )
