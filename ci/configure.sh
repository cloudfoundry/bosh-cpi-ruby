#!/usr/bin/env bash

set -eu

fly -t "${CONCOURSE_TARGET:-bosh}" set-pipeline -p bosh-cpi-ruby \
  -c ci/pipeline.yml
