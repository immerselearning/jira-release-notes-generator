require_relative "./release_reporter"
require_relative "./json_issue"

class StdOutConfluenceReporter < ReleaseReporter
  def open_section(name)
    print "h3. #{name}\n"
  end

  def close_section
    print "\n"
  end

  def <<(issue)
    print "- [\\[#{issue.id}\\]|#{issue.link}] #{issue.name}\n"
  end
end
