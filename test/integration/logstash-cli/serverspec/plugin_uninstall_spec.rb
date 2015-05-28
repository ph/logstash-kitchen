# Encoding: utf-8
require_relative "../../../kitchen/files/spec_helper"

describe "bin/plugin uninstall" do
  context "when the plugin isn't installed" do
    describe command("/opt/logstash/bin/plugin uninstall logstash-filter-cidr") do
      its(:stdout) { is_expected.to match(/This plugin has not been previously installed, aborting/)  }
      its(:exit_status) { is_expected.to eq(1) }
    end
  end

  context "when the plugin is installed" do
    describe command("/opt/logstash/bin/plugin uninstall logstash-filter-ruby") do
      its(:stdout) { is_expected.to match(/Uninstalling logstash-filter-ruby/) }
      its(:exit_status) { is_expected.to eq(0) }
    end
  end
end
