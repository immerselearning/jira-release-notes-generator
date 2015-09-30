require "pp"

class JSONIssue
  def initialize(json)
    @json = json
    @id = @json["key"]
    @name = @json["fields"]["summary"]
  end

  def id
    @id
  end

  def name
    @name
  end

  def is_bug?
    @json["fields"]["issuetype"]["id"] != "7"
  end

  def is_done?
    @json["fields"]["status"]["name"] == "Done"
  end

  def belongs_to_sprint?(sprint_id)
    sprint = @json["fields"]["sprint"]
    sprint.nil? || sprint["id"] == sprint_id
  end

  def to_s
    "<" + @id + ": " + @name + ">"
  end
end
