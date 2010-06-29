module Fetcher
  class Github
    attr_reader :uri, :user, :repo
    
    COMMITS_URI_TEMPLATE = "http://github.com/api/v2/json/commits/list/%s/%s/master"
    TAGS_URI_TEMPLATE = "http://github.com/api/v2/json/repos/show/%s/%s/tags"
    URI_VALIDATOR = /^\s*(http:\/\/|git:\/\/)?github.com\/[^\/]+\/[^\/]+\/?\s*$/i
    TIME_KEYS = ["committed_date", "authored_date"]
    
    def initialize(uri)
      @uri = uri.strip.downcase
      raise ApiError, "invalid github uri" unless @uri =~ URI_VALIDATOR
      @user, @repo = *@uri.scan(/github\.com\/([^\/]+)\/([^\/]+)/i).flatten
    end

    def commits(reload = false)
      if reload
        @commits = fetch_and_process_commits
      else
        @commits ||= fetch_and_process_commits
      end
    end
    
    def tags(reload = false)
      if reload
        @tags = fetch_tags
      else
        @tags ||= fetch_tags
      end
    end
    
    def commits_uri
      sprintf(COMMITS_URI_TEMPLATE, @user, @repo)
    end
    
    def tags_uri
      sprintf(TAGS_URI_TEMPLATE, @user, @repo)
    end
    
    private
    
    def fetch_tags
      tags = JSON.parse(Typhoeus::Request.get(tags_uri).body)
      if tags.key? 'tags'
        tags['tags']
      else
        raise ApiError, "response missing required 'tags' key"
      end
    rescue JSON::ParserError => e
      raise ApiError, e.message
    end
    
    def fetch_and_process_commits
      commits = fetch_commits
      commits = parse_time_values(commits)
    end
    
    def fetch_commits
      commits = JSON.parse(Typhoeus::Request.get(commits_uri).body)
      if commits.key? 'commits'
        commits['commits']
      else
        raise ApiError, "response missing required 'commits' key"
      end
    rescue JSON::ParserError => e
      raise ApiError, e.message
    end

    def parse_time_values(commits)
      commits.each do |commit|
        TIME_KEYS.each do |time_key|
          if commit[time_key]
            commit[time_key] = Time.parse(commit[time_key])
          end
        end
      end
      
      commits
    end
  end
end