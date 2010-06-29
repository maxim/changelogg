require 'spec_helper'

describe Fetcher::Github do
  include UriStubbing
  
  it "should retain uri" do
    fetcher = Fetcher::Github.new('http://github.com/maxim/changelogg')
    fetcher.uri.should == 'http://github.com/maxim/changelogg'
  end
  
  it "should extract user and repo correctly" do
    fetcher = Fetcher::Github.new('http://github.com/maxim/changelogg')
    fetcher.user.should == 'maxim'
    fetcher.repo.should == 'changelogg'
  end
  
  it "should build commits uri correctly" do
    fetcher = Fetcher::Github.new('http://github.com/maxim/changelogg')
    fetcher.commits_uri.should == "http://github.com/api/v2/json/commits/list/maxim/changelogg/master"
  end
  
  it "should build tags uri correctly" do
    fetcher = Fetcher::Github.new('http://github.com/maxim/changelogg')
    fetcher.tags_uri.should == "http://github.com/api/v2/json/repos/show/maxim/changelogg/tags"
  end

  it "should pull commits from uri" do
    stub_uri "http://github.com/api/v2/json/commits/list/maxim/changelogg/master",
             '{"commits":[{"commit1":"commit1"},{"commit2":"commit2"}]}'

    fetcher = Fetcher::Github.new('http://github.com/maxim/changelogg')
    fetcher.commits.should == [{"commit1" => "commit1"}, {"commit2" => "commit2"}]
  end
  
  it "should raise error when malformed response received for commits" do
    stub_uri "http://github.com/api/v2/json/commits/list/maxim/changelogg/master", '{}'

    fetcher = Fetcher::Github.new('http://github.com/maxim/changelogg')
    lambda { fetcher.commits }.should raise_error(Fetcher::ApiError)
  end
  
  it "should raise error when malformed response received for tags" do
    stub_uri "http://github.com/api/v2/json/repos/show/maxim/changelogg/tags", '{}'
    
    fetcher = Fetcher::Github.new('http://github.com/maxim/changelogg')
    lambda { fetcher.tags }.should raise_error(Fetcher::ApiError)
  end
  
  it "should raise error when invalid uri supplied" do
    lambda { fetcher = Fetcher::Github.new('foobar') }.should raise_error(Fetcher::ApiError)
  end
  
  it "should recognize and parse committed_date and authored_date" do
    stub_uri "http://github.com/api/v2/json/commits/list/maxim/changelogg/master",
             '{"commits":[
                {"committed_date":"2009-03-31T09:54:51-07:00","foo":"bar"},
                {"authored_date":"2009-03-31T09:54:51-07:00"}
              ]}'
    
    fetcher = Fetcher::Github.new('http://github.com/maxim/changelogg')
    commits = fetcher.commits
    
    commits[0]['committed_date'].should be_a_kind_of(Time)
    commits[0]['foo'].should_not be_a_kind_of(Time)
    commits[1]['authored_date'].should be_a_kind_of(Time)
  end
  
  it "should pull git tags from uri" do
    stub_uri "http://github.com/api/v2/json/repos/show/maxim/changelogg/tags",
             '{"tags":{"1.0":"foo","2.0":"bar"}}'
    
    fetcher = Fetcher::Github.new('http://github.com/maxim/changelogg')
    fetcher.tags.should == {"1.0" => "foo", "2.0" => "bar"}
  end
end
