require 'spec_helper'

describe Repository do
  it "should not be valid without a uri" do
    repository = Repository.new
    repository.should_not be_valid
    repository.errors.should have_key(:uri)
  end
end
