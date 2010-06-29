class Commit
  include Mongoid::Document
  include Mongoid::Timestamps
  embedded_in :repository, :inverse_of => :commits
  
  def tag
    self['tag']
  end
end
