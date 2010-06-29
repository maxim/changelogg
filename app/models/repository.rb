class Repository
  include Mongoid::Document
  include Mongoid::Timestamps

  field :uri, :type => String
  embeds_many :commits

  validates :uri, :presence => true, :format => FETCHER::URI_VALIDATOR

  before_create :fetch_commits!

  def uri=(given_uri)
    given_uri = "http://github.com/#{given_uri.sub(/^\//, '')}" if given_uri !~ /github\.com/ && !given_uri.blank?
    given_uri = "http://#{given_uri}" if given_uri !~ /^[^:]+:\/\//i && !given_uri.blank?
    write_attribute(:uri, given_uri)
  end
  
  def fetch_commits!
    fetcher = FETCHER.new(uri)
    self.commits = fetcher.commits
    tags = fetcher.tags
    
    commits.each do |commit|
      tags.each do |tag_name, tag_commit_id|
        if commit.id == tag_commit_id
          commit['tag'] = tag_name
        end
      end
    end
  end
end