require "./json_issue"

class Release
  STORIES_LABEL="Changes"
  BUGFIXES_LABEL="Bugs resolved"
  KNOWN_BUGS="Known issues"

  def initialize(version_id, provider, reporter)
    @provider = provider
    @reporter = reporter
    @id = "unknown"
    @stories = []
    @bugs_resolved = []
    @known_issues = []

    handle_version_issue = ->(version_id, issue) {
      ((issue.is_bug?) ? @bugs_resolved : @stories) << issue
    }

    handle_open_bug = ->(issue) {
      @known_issues << issue
    }

    self.classify(provider.get_version(version_id),
      handle_version_issue.curry.(version_id))
    self.classify(provider.get_open_bugs, handle_open_bug)
  end

  def report_notes
    {
      STORIES_LABEL => @stories,
      BUGFIXES_LABEL => @bugs_resolved,
      KNOWN_BUGS => @known_issues
    }.each do |label, issues|
      @reporter.open_section label
      issues.each do |issue|
        @reporter << issue
      end
      @reporter.close_section
    end
  end

  def classify(issues, issue_handler)
    issues.each do |i|
      issue = JSONIssue.new(i)
      issue_handler.call(issue)
    end
  end
end
