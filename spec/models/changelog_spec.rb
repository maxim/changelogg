require 'spec_helper'

describe Changelog do
  before(:each) do
    @repository =  Factory.create(:repository)
    @repository.fetch_commits!
    @changelog = Changelog.new(@repository)
  end

  it "should have entries array" do
    @changelog.entries.should be_a_kind_of(Array)
  end
end
