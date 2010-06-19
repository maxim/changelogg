require 'spec_helper'

describe "changelogs/show.html.erb" do
  before(:each) do
    assign(:changelog, Changelog.new(Repository.create(:uri => 'http://github.com/maxim/changelogg')))
  end
  
  it "renders changelog entries" do
    render
    rendered.should have_selector("#entries")
  end
end