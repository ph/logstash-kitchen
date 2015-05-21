# Encoding: utf-8
require_relative "../../../kitchen/files/spec_helper"

describe "stdin to elasticsearch" do
  let(:number_of_events) { IO.readlines(sample_log).size }
  let(:sample_log) { "/tmp/kitchen/files/sample.log" }
  let(:config_file) { "/tmp/kitchen/files/complete_#{protocol}.conf" }

  after do
    FileUtils.rm_rf(config_file)
  end

  ["http", "node", "transport"].each do |new_protocol|
    context "with #{new_protocol} protocol" do
      let(:protocol) { new_protocol }
      before :each do
        LogStashTestHelpers.delete_logstash_events
      end

      it "insert new documents into elasticsearch" do
        expect { 
          raw_command("/opt/logstash/bin/logstash -f #{config_file} < #{sample_log}")
        }.to change(LogStashTestHelpers, :count_logstash_events).by(number_of_events)

        event = LogStashTestHelpers.get_random_event
        expect(event).to include("message", "@version", "@timestamp", "host", "clientip", "ident", "auth", "timestamp", "verb", "request", "httpversion", "response", "bytes", "referrer", "agent", "geoip", "useragent")
      end
    end
  end
end
