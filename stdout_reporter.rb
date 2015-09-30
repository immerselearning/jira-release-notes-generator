require "./release_reporter"
require "./json_issue"

class StdOutReporter < ReleaseReporter
  def open_section(name)
    print "#{name}\n"
  end

  def close_section
    print "\n"
  end

  def <<(issue)
    print "[#{issue.id}] #{issue.name}\n"
  end
end
