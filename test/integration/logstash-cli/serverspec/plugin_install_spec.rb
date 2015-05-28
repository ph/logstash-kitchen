# Encoding: utf-8
require_relative "../../../kitchen/files/spec_helper"
require "fileutils"

context "bin/plugin install" do
  before(:all) { raw_command("wget https://rubygems.org/downloads/logstash-input-wmi-0.1.5-java.gem; cp /home/kitchen/logstash-input-wmi*.gem /tmp") }

  context command("/opt/logstash/bin/plugin install --no-verify /tmp/logstash-input-wmi-0.1.5-java.gem") do
    its(:exit_status) { is_expected.to eq(0) }
    its(:stdout) { is_expected.to match(/Installing logstash-input-wmi/) }
    its(:stdout) { is_expected.to match(/Installation successful/) }
  end

  context "when the plugin exist" do
    describe command("/opt/logstash/bin/plugin install logstash-input-drupal_dblog") do
      its(:exit_status) { is_expected.to eq(0) }
      its(:stdout) { is_expected.to match(/^Installing logstash-input-drupal_dblog/) }
      its(:stdout) { is_expected.to match(/Installation successful/) }
    end

    describe command("/opt/logstash/bin/plugin install --version 0.1.6 logstash-input-drupal_dblog") do
      its(:exit_status) { is_expected.to eq(0) }
      its(:stdout) { is_expected.to match(/^Installing logstash-input-drupal_dblog/) }
      its(:stdout) { is_expected.to match(/Installation successful/) }
    end
  end

  context "when the plugin doesn't exist" do
    describe command("/opt/logstash/bin/plugin install logstash-output-impossible-plugin") do
      its(:exit_status) { is_expected.to eq(1) }
      its(:stdout) { is_expected.to match(/Plugin logstash-output-impossible-plugin does not exist/) }

      describe command("/opt/logstash/bin/plugin list logstash-output-impossible-plugin") do
        its(:stdout) { is_expected.to match(/No plugins found/) }
      end
    end
  end
end
