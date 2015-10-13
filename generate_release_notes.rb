#!/usr/bin/ruby

require_relative "release"
require_relative "jira/version"
require_relative "jira/json_provider"
require_relative "stdout_confluence_reporter"

if ARGV.length == 0
  print "USAGE: ruby generate_release_notes.rb VERSION_NAME\n"
  exit -1
end

project_root = File.dirname(File.absolute_path(__FILE__))
Jira::Utils::load_config("#{project_root}/jira/config.yaml")

version = Jira::Version::by_name(ARGV[0])

if version.nil?
  print "Unrecognized version #{ARGV[0]}\n"
  exit -1
else
  print "Version #{version.name}\n"
end

Release.new(
  Jira::Version::by_name(ARGV[0]),
  Jira::JSONProvider.new,
  StdOutConfluenceReporter.new
).report_notes
