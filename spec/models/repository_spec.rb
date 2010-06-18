require 'spec_helper'

describe Repository do
  include UriStubbing
  
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
  
  it "should populate its commits" do
    stub_uri "http://github.com/api/v2/json/commits/list/maxim/changelogg/master",
             '{"commits":[{"commit1":"commit1"},{"commit2":"commit2"}]}'
    
    repository = Repository.new(:uri => "http://github.com/maxim/changelogg")
    repository.fetch_commits!
    
    repository.commits.size.should == 2
    repository.commits.first.commit1.should == 'commit1'
    repository.commits.second.commit2.should == 'commit2'
  end
end
