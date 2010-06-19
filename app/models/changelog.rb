class Changelog
  attr_accessor :repository
  
  def initialize(repository)
    @repository = repository
  end
  
  def entries
    @repository.commits.map(&:message)
  end
end