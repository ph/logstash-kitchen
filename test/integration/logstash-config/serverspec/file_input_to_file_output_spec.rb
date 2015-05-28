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
    # We have to set a 0 stat interval to have the right number of events
    # on shutdown the events arent flushed to disk correctly
    expect(IO.readlines(output_file).size).to eq(number_of_events)
  end
end

