#!/usr/bin/env bash

set -eu

fly -t bosh-ecosystem sp -p bosh-cpi-ruby \
  -c ci/pipeline.yml
