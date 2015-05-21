# Encoding: utf-8
require_relative "../../../kitchen/files/spec_helper"

describe "bin/plugin list" do
  context "without a specific plugin" do
    describe command("/opt/logstash/bin/plugin list") do
      its(:exit_status) { is_expected.to eq(0) }

      it "display a list of plugins" do
        expect(subject.stdout.split("\n").size).to be > 1
      end
    end

    describe command("/opt/logstash/bin/plugin list --installed") do
      its(:exit_status) { is_expected.to eq(0) }
    end
  end

  context "with a specific plugin" do 
    describe command("/opt/logstash/bin/plugin list logstash-input-stdin") do
      its(:exit_status) { is_expected.to eq(0) }

      it "display matching name" do
        expect(subject.stdout).to match(/^logstash-input-stdin/)
      end
    end

    describe command("/opt/logstash/bin/plugin list --verbose logstash-input-stdin") do
      its(:exit_status) { is_expected.to eq(0) }

      it "only display a specific plugin" do
        expect(subject.stdout).to match(/^logstash-input-stdin \(\d+\.\d+.\d+\)/)
      end
    end
  end
end
