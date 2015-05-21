require "serverspec"
require_relative "logstash_test_helpers"
RSpec.configure do |config|
  config.fail_fast = true
  config.order = "random"

  if ENV["JENKINS"]
    config.formatter = "RspecJunitFormatter"
    config.output_stream = File.open("serverspec-result.xml", "w")
  end
end

set :backend, :exec
set :path, "/sbin:/usr/local/sbin:$PATH"

