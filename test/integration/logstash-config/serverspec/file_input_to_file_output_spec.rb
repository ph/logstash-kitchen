# Encoding: utf-8
require_relative "../../../kitchen/files/spec_helper"

describe "File input to File output" do
  let(:number_of_events) { IO.readlines(sample_log).size }
  let(:sample_log) { "/tmp/kitchen/files/sample.log" }
  let(:output_file) { "/tmp/out.log" }

  before :all do
    config = 'input { file { path => "/tmp/kitchen/files/sample.log" stat_interval => 0 start_position => "beginning" } } output { file { path => "/tmp/out.log" } }'
    cmd = "/opt/logstash/bin/logstash -e '#{config}'"

    launch_logstash(cmd)
  end

  it "creates an output file" do
    expect(File.exist?(output_file)).to eq(true)
  end

  it "writes events to file" do
    # on shutdown the events arent flushed to disk correctly
    # Known issue https://github.com/logstash-plugins/logstash-output-file/issues/12
    expect(IO.readlines(output_file).size).to be_between(48, number_of_events).inclusive
  end
end

