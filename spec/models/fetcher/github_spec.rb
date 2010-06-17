require 'spec_helper'

describe Fetcher::Github do
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
  
  it "should pull commits from uri" do
    response = Typhoeus::Response.new :code => 200, :body => '{"response":{"from":"github"}}'
    Typhoeus::Request.stub(:get, "http://github.com/api/v2/json/commits/list/maxim/changelogg/master").
                      and_return(response)
    
    fetcher = Fetcher::Github.new('http://github.com/maxim/changelogg')
    fetcher.commits.should == {"response" => {"from" => "github"}}
  end
  
  it "should raise error when invalid uri supplied" do
    lambda { fetcher = Fetcher::Github.new('foobar') }.should raise_error(Fetcher::ApiError)
  end
end
