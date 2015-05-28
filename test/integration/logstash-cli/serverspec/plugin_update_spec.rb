# Encoding: utf-8
require_relative "../../../kitchen/files/spec_helper"
describe "update" do
  let(:plugin) { "logstash-input-stdin" }
  let(:previous_version) { "0.1.5" }

  before do
    raw_command("/opt/logstash/bin/plugin install --version #{previous_version} #{plugin}")
  end

  context command("/opt/logstash/bin/plugin update logstash-input-stdin") do
    it "has executed succesfully" do
      expect(subject.exit_status).to eq(0)
    end

    it "display a success message" do
      expect(subject.stdout).to match(/Installation #{plugin} \([^#{LogStashTestHelpers.latest_version(plugin)}]\)/)
    end
  end

  context "without specifying a plugin" do
    subject { command("/opt/logstash/bin/plugin update") }

    it "has executed succesfully" do
      expect(subject.exit_status).to eq(0)
    end

    it "display a success message" do
      expect(subject.stdout).to match(/^Updated #{plugin} #{previous_version} to \([^#{LogStashTestHelpers.latest_version(plugin)}]\)/)
    end
  end
end
