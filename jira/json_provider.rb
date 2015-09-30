require "json"
require "rest-client"

require_relative "../issue_provider"
require_relative "auth"

module Jira
  class JSONProvider < IssueProvider
    def get_version(version_id)
      Jira::Utils::search_issues(
        "fixVersion = #{version_id}"
      )
    end

    def get_open_bugs
      Jira::Utils::search_issues(
        "status != Done"\
        " AND project = #{Jira::config["project"]["name"]}"\
        " AND type = Bug"\
        " ORDER BY id"
      )
    end
  end
end
