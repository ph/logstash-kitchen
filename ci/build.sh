#!/bin/sh
echo "ruby version `ruby -v`"
echo "test kitchen version: `bundle exec kitche version`"
bundle exec kitchen test
