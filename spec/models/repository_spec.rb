require 'spec_helper'

describe Repository do
  it "should not be valid without a uri" do
    repository = Repository.new
    repository.should_not be_valid
    repository.errors.should have_key(:uri)
  end
  
  it "should not be valid with malformed uri" do
    repository = Repository.new(:uri => 'foobar')
    repository.should_not be_valid
    repository.errors.should have_key(:uri)
  end
  
  it "should be valid with real uri" do
    repository = Repository.new(:uri => "http://github.com/maxim/changelogg")
    repository.should be_valid
  end
  
  it "should be unchanged if protocol already present" do
    repository = Repository.new(:uri => "http://github.com/maxim/changelogg")
    repository.uri.should == "http://github.com/maxim/changelogg"
  end
  
  it "should add http:// to uri if no protocol was specified" do
    repository = Repository.new(:uri => "github.com/maxim/changelogg")
    repository.uri.should == 'http://github.com/maxim/changelogg'
    repository.should be_valid
  end
end
