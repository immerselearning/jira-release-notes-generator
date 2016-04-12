require_relative './release_reporter'
require_relative './json_issue'

class StdOutReporter < ReleaseReporter
  def open_section(name)
    puts name.to_s
  end

  def close_section
    print "\n"
  end

  def <<(issue)
    puts "[#{issue.id}] #{issue.name}"
  end
end
