require_relative 'auth'

module Jira
  class Version
    def self.by_name(name)
      url = "#{Jira.api_url}/project/#{Jira.project_id}/versions"
      regex = Regexp.new(name)
      versions = Jira::Utils.get_JSON_from_url(url)
      versions.detect { |v| regex =~ v['name'] }.tap do |v_data|
        return nil if v_data.nil?
        return Jira::Version.new(v_data)
      end
    end

    def initialize(json)
      @json = json
    end

    def to_s
      @json['id']
    end

    def method_missing(sym, *_, &__)
      puts sym.to_s
      @json[sym.to_s]
    end
  end
end
