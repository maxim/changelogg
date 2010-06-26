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
  
  it "should add http://github.com/ if no domain was specified" do
    repository = Repository.new(:uri => "maxim/changelogg")
    repository.uri.should == 'http://github.com/maxim/changelogg'
    repository.should be_valid
  end
  
  it "should add http://github.com/ if no domain was specified" do
    repository = Repository.new(:uri => "maxim/changelogg")
    repository.uri.should == 'http://github.com/maxim/changelogg'
    repository.should be_valid
  end
  
  it "should add http://github.com if no domain was specified, but started with slash" do
    repository = Repository.new(:uri => "/maxim/changelogg")
    repository.uri.should == 'http://github.com/maxim/changelogg'
    repository.should be_valid
  end
  
  it "should populate its commits" do
    repository = Repository.new(:uri => "http://github.com/maxim/changelogg")
    repository.fetch_commits!
    
    repository.commits.size.should == 3
    repository.commits.first.tree.should == 'b4ed90aea9846cd5857508b4353cf4daeee59eb2'
    repository.commits.second.tree.should == '23c480ee1b11c1b3aecca3b0510c84afe8c3f19b'
  end
end
