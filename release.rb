require_relative './json_issue'

class Release
  STORIES_LABEL = 'Changes'.freeze
  BUGFIXES_LABEL = 'Bugs resolved'.freeze
  KNOWN_BUGS = 'Known issues'.freeze

  def initialize(version_id, provider, reporter)
    @provider = provider
    @reporter = reporter
    @id = 'unknown'
    @stories = []
    @bugs_resolved = []
    @known_issues = []

    handle_version_issue = lambda do |_, issue|
      (issue.bug? ? @bugs_resolved : @stories) << issue
    end
    handle_open_bug = ->(i) { @known_issues << i }
    classify(
      provider.version(version_id),
      handle_version_issue.curry.call(version_id)
    )
    classify(provider.open_bugs, handle_open_bug)
  end

  def report_notes
    {
      STORIES_LABEL => @stories,
      BUGFIXES_LABEL => @bugs_resolved,
      KNOWN_BUGS => @known_issues
    }.each do |label, issues|
      next if issues.empty?
      @reporter.open_section label
      issues.each do |issue|
        @reporter << issue
      end
      @reporter.close_section
    end
  end

  def classify(issues, issue_handler)
    issues.each { |i| issue_handler.call(JSONIssue.new(i)) }
  end
end
