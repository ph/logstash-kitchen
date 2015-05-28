#!/bin/sh
echo "ruby version `ruby -v`"
bundle exec kitchen test
