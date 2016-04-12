require 'json'
require 'rest-client'

require_relative '../issue_provider'
require_relative 'auth'

module Jira
  class JSONProvider < IssueProvider
    def version(version_id)
      Jira::Utils.search_issues(
        "project = #{Jira.config['jira_project']['name']}"\
        " AND fixVersion = #{version_id}"\
        ' AND ('\
          "affectedVersion != #{version_id}"\
          ' OR affectedVersion = null'\
        ')'\
        ' AND status = Done'\
      )
    end

    def open_bugs
      Jira::Utils.search_issues(
        'resolution = Unresolved'\
        " AND project = #{Jira.config['jira_project']['name']}"\
        ' AND type = Bug'\
        ' ORDER BY id'
      )
    end
  end
end
