require "yaml"
require "pp"

module Jira
  def self.config
    @@config
  end

  def self.load_config(path)
    @@config = YAML.load_file(path)
  end

  class Utils
    def self.load_config(path)
      Jira::load_config path
    end

    def self.get_JSON_from_url(url, params = {})
      user = Jira::config["auth"]["user"]
      password = Jira::config["auth"]["password"]
      resource = RestClient::Resource.new(url, user, password)
      begin
        response =
          if params
            resource.get :content_type => :json, :params => params
          else
            resource.get :content_type => :json
          end
      rescue => e
        pp params
        pp e
      end
      JSON.load(response.body)
    end

    def self.search_issues(query)
      url = "#{Jira::config["server"]["api_url"]}/search"
      self.get_JSON_from_url(url, :jql => query)["issues"]
    end
  end
end
