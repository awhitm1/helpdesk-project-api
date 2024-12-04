#!/usr/bin/env bash 
# exit on error
set -o errexit
node --version
bundle install

bundle exec rake db:migrate