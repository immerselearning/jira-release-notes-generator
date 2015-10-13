# jira-release-notes-generator

### Setup
1. clone repo
2. copy jira/default.yaml to jira/config.yaml
3. set your username and password in jira/config.yaml
4. run `bundle install` in the repo root

### Usage
`ruby generate_release_notes.rb VERSION_NAME`

This program will search for a version with `VERSION_NAME` in it (`VERSION_NAME` can even be a regex) and print its release notes on the standard output.
