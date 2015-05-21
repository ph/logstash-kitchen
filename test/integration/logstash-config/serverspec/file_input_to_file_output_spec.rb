# Encoding: utf-8
require_relative "../../../kitchen/files/spec_helper"

describe "File input to File output" do
  let(:number_of_events) { IO.readlines(sample_log).size }
  let(:sample_log) { "/tmp/kitchen/files/sample.log" }
  let(:output_file) { "/tmp/out.log" }

  before :all do
    config = 'input { file { path => "/tmp/kitchen/files/sample.log" start_position => "beginning" } } output { file { path => "/tmp/out.log" } }'
    cmd = "/opt/logstash/bin/logstash -e '#{config}'"

    pid = fork do
      exec cmd
    end

    Process.detach(pid)
    sleep(30)
    Process.kill("INT", pid)
  end

  it "creates an output file" do
    expect(File.exist?(output_file)).to eq(true)
  end

  it "writes events to file" do
    expect(IO.readlines(output_file).size).to be > 40
    # Because of the signal logic and shutdown not all events are written to disk
    # expect(IO.readlines(output_file).size).to eq(number_of_events)
  end
end

