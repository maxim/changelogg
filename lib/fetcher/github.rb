module Fetcher
  class Github
    attr_reader :uri, :user, :repo
    
    COMMITS_URI_TEMPLATE = "http://github.com/api/v2/json/commits/list/%s/%s/master"
    URI_VALIDATOR = /^(http:\/\/|git:\/\/)?github.com\/[^\/]+\/[^\/]+\/?/i
    
    def initialize(uri)
      @uri = uri.strip.downcase
      raise ApiError, "invalid github uri" unless @uri =~ URI_VALIDATOR
      @user, @repo = *@uri.scan(/github\.com\/([^\/]+)\/([^\/]+)/i).flatten
    end

    def commits(reload = false)
      if reload
        @commits = fetch_commits
      else
        @commits ||= fetch_commits
      end
    end
    
    def commits_uri
      sprintf(COMMITS_URI_TEMPLATE, @user, @repo)
    end
    
    private
    def fetch_commits
      commits = JSON.parse(Typhoeus::Request.get(commits_uri).body)
      if commits.key? 'commits'
        commits['commits']
      else
        raise ApiError, "response missing required commits key"
      end
    rescue JSON::ParserError => e
      raise ApiError, e.message
    end
  end
end