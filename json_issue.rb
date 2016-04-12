require 'pp'

class JSONIssue
  attr_accessor :id, :name, :link

  def initialize(json)
    @json = json
    @id = @json['key']
    @name = @json['fields']['summary']
    @link = "https://immerselearning.atlassian.net/browse/#{id}"
  end

  def bug?
    @json['fields']['issuetype']['id'] != '7'
  end

  def done?
    @json['fields']['resolution'].nil?
  end

  def belongs_to_sprint?(sprint_id)
    sprint = @json['fields']['sprint']
    sprint.nil? || sprint['id'] == sprint_id
  end

  def to_s
    '<' + @id + ': ' + @name + '>'
  end
end
