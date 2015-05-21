# Encoding: utf-8
require_relative "../../../kitchen/files/spec_helper"

describe "bin/logstash" do
  describe command("/opt/logstash/bin/logstash version") do
    its(:exit_status) { is_expected.to eq(0) }
    its(:stdout) { is_expected.to match(/^logstash\s\d+\.\d+\.\d+/) }
  end
end
