require 'json'

require_relative './issue_provider'

class FileJSONProvider < IssueProvider
  VERSION_PATH = './version.json'.freeze
  OPEN_BUGS_PATH = './open_bugs.json'.freeze

  def file_to_JSON(filename)
    File.open(filename) do |f|
      JSON.load(f)
    end
  end

  def version(_version_id)
    file_to_JSON(VERSION_PATH)['issues']
  end

  def open_bugs
    file_to_JSON(OPEN_BUGS_PATH)['issues']
  end
end
