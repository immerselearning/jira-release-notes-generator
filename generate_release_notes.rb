#!/usr/bin/ruby

require_relative 'release'
require_relative 'jira'
require_relative 'stdout_confluence_reporter'

def load_jira_config
  path = File.symlink?(__FILE__) ? File.readlink(__FILE__) : __FILE__
  project_root = File.dirname(File.absolute_path(path))
  Jira.load_config("#{project_root}/jira/config.yaml")
end

def find_version
  load_jira_config
  Jira::Version.by_name(ARGV[0]).tap do |v|
    abort "Unrecognized version #{ARGV[0]}" if v.nil?
  end
end

def reporters
  [
    Jira::JSONProvider.new,
    StdOutConfluenceReporter.new
  ]
end

abort 'USAGE: ruby generate_release_notes.rb VERSION_NAME' if ARGV.empty?
version = find_version
puts "Version #{version.name}"
Release.new(version, *reporters).report_notes
