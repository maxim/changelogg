class Repository
  include Mongoid::Document
  include Mongoid::Timestamps
  field :uri, :type => String
  
  validates :uri, :presence => true
end
