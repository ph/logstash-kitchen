#!/bin/bash
echo "ruby version `ruby -v`"

bundle exec kitchen test logstash-cli
