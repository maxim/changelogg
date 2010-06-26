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
    self.commits = FETCHER.new(uri).commits
  end
end