class Repository
  include Mongoid::Document
  include Mongoid::Timestamps
  field :uri, :type => String

  validates :uri, :presence => true, :uri => true

  def uri=(given_uri)
    given_uri = "http://#{given_uri}" if given_uri !~ /^[^:]+:\/\//i
    write_attribute(:uri, given_uri)
  end
end