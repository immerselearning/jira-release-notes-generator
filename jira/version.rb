require "rest-client"

require_relative "auth"

module Jira
  class Version
    def self.by_name(name)
      url = "#{Jira::config["server"]["api_url"]}/project/#{Jira::config["project"]["id"]}/versions"
      versions = Jira::Utils.get_JSON_from_url(url)
      found_version = nil
      regex = Regexp.new(name)
      versions.each do |version|
        if regex =~ version["name"]
          found_version = new(version)
          break
        end
      end
      found_version
    end

    def initialize(json)
      @json = json
    end

    def to_s
      @json["id"]
    end

    def method_missing(sym, *args, &block)
      @json[sym.to_s]
    end
  end
end
