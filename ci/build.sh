#!/bin/bash
echo "ruby version `ruby -v`"
# I have to run this through cat, because there is not way to disable colour in test-kitchen.
# https://github.com/test-kitchen/test-kitchen/issues/330
bundle exec kitchen test all | cat
