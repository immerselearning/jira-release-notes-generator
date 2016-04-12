require 'yaml'

require_relative 'jira/auth.rb'
require_relative 'jira/json_provider'
require_relative 'jira/version'

module Jira
  def self.config
    @config
  end

  def self.load_config(path)
    @config = YAML.load_file(path)
  end

  def self.api_url
    @config['server']['root_url'] + @config['server']['jira_url']
  end

  def self.project_id
    @config['jira_project']['id']
  end
end
