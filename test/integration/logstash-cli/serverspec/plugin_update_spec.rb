# Encoding: utf-8
require_relative "../../../kitchen/files/spec_helper"
describe "update" do
  let(:plugin) { "logstash-input-stdin" }
  let(:previous_version) { "0.1.5" }

  before do
    raw_command("/opt/logstash/bin/plugin install --version #{previous_version} #{plugin}")
    cmd = command("/opt/logstash/bin/plugin list --verbose logstash-input-stdin")
    expect(cmd.stdout).to match(/#{plugin} \(#{previous_version}\)/)
  end

  context "update a specific plugin" do
    subject { command("/opt/logstash/bin/plugin update logstash-input-stdin") }

    it "has executed succesfully" do
      expect(subject.exit_status).to eq(0)
      expect(subject.stdout).to match(/Updating #{plugin}/)
    end
  end

  context "update all the plugins" do
    subject { command("/opt/logstash/bin/plugin update") }

    it "has executed succesfully" do
      expect(subject.exit_status).to eq(0)
      cmd = command("/opt/logstash/bin/plugin list --verbose logstash-input-stdin").stdout
      expect(cmd).to match(/logstash-input-stdin \(#{LogStashTestHelpers.latest_version(plugin)}\)/)
    end
  end
end
