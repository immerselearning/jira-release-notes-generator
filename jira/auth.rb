require 'json'
require 'rest-client'
require 'pp'

module Jira
  class Utils
    PAGE_SIZE = 50

    def self.get_JSON_from_url(url, params = {})
      response = RestClient::Resource.new(
        url,
        user: Jira.config['auth']['user'],
        password: Jira.config['auth']['password']
      ).get(
        content_type: :json,
        params: params
      )
      JSON.load(response.body)
    rescue RestClient::Exception => e
      pp params, e
    end

    def self.search_issues(query)
      url = "#{Jira.api_url}/search"
      [].tap do |issues|
        page_start = 0
        loop do
          response = get_JSON_from_url(
            url,
            jql: query,
            startAt: page_start,
            maxResults: PAGE_SIZE
          )
          issues << response['issues']
          break unless response['startAt'] + PAGE_SIZE < response['total']
          page_start += PAGE_SIZE
        end
      end.flatten(1)
    end
  end
end
