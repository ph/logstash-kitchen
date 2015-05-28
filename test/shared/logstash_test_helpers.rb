require "net/http"
require "uri"
require "json"
require "elasticsearch"
require "open3"

module LogStashTestHelpers
  RANDOM_PREVIOUS_VERSION_LIMIT = 3
  ELASTICSEARCH_HOST = "http://127.0.0.1:9200"

  @@cached = {}

  def self.random_plugin
    ["logstash-input-stdin"].sample
  end

  def self.latest_version(name)
    get_rubygems_specification(name).first.fetch("number")
  end

  def self.random_previous_version(name, skip = 0, limit = RANDOM_PREVIOUS_VERSION_LIMIT)
    get_rubygems_specification(name).slice(skip, limit).sample.fetch("number")
  end

  def self.get_rubygems_specification(name)
    @@cached[name] ||= make_api_call("http://rubygems.org/api/v1/versions/#{name}.json")
  end


  def self.make_api_call(url, verb = :get)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    req = case verb
          when :post
            Net::HTTP::Post.new(uri.path)
          when :get
            Net::HTTP::Get.new(uri.path)
          when :delete
            Net::HTTP::Delete.new(uri.path)
          end

    response = http.request(req)
    JSON.parse(response.body)
  end

  def self.es
    Elasticsearch::Client.new(:host => ELASTICSEARCH_HOST)
  end

  def self.count_logstash_events
    es.indices.refresh :index => "logstash*"
    result = es.count :index => "logstash*"
    result["count"]
  end

  def self.delete_logstash_events
    es.indices.delete :index => "_all"
  end

  def self.get_random_event
    result = es.search :body => {
      :query => {
        :match_all => {}
      },
      :size => 1
    }

    result["hits"]["hits"].first["_source"]
  end
end

def raw_command(cmd, verbose = nil)
  Open3.popen3(cmd) do |i, o|
    if verbose
      p o.read
    else 
      o.read
    end
  end
end

def launch_logstash(cmd)
  pid = fork do
    exec cmd
  end

  Process.detach(pid)
  sleep(30)
  Process.kill("INT", pid)
end
