# Encoding: utf-8
require_relative "../../../kitchen/files/spec_helper"
# describe "update" do
#   let(:plugin) { LogStashTestHelpers::random_plugin }
#   let(:previous_version) { LogStashTestHelpers::random_previous_version(plugin, 1) }

#   before do
#     command("/opt/logstash/bin/plugin install --version #{previous_version} #{plugin}")
#   end

#   context "when specifying a plugin" do
#     subject { command("/opt/logstash/bin/plugin update #{plugin}") }

#     it "has executed succesfully" do
#       expect(subject.exit_status).to eq(0)
#     end

#     it "display a success message" do
#       expect(subject.stdout).to match(/^Installation #{plugin} \([^#{LogStashTestHelpers.latest_version(plugin)}]\)/)
#     end
#   end

#   context "without specifying a plugin" do
#     subject { command("/opt/logstash/bin/plugin update") }

#     it "has executed succesfully" do
#       expect(subject.exit_status).to eq(0)
#     end

#     it "display a success message" do
#       expect(subject.stdout).to match(/^Installation #{plugin} \([^#{LogStashTestHelpers.latest_version(plugin)}]\)/)
#     end
#   end
# end
