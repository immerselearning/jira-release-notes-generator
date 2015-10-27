require "json"
require_relative "./issue_provider"

class FileJSONProvider < IssueProvider
  VERSION_PATH = "./version.json"
  OPEN_BUGS_PATH = "./open_bugs.json"

  def get_JSON_from_file(filename)
    File.open(filename) do |f|
      JSON.load(f)
    end
  end

  def get_version(version_id)
    get_JSON_from_file(VERSION_PATH)["issues"]
  end

  def get_open_bugs
    get_JSON_from_file(OPEN_BUGS_PATH)["issues"]
  end
end
