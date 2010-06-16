require 'spec_helper'

describe "repositories/new.html.erb" do
  before(:each) do
    assign(:repository, stub_model(Repository,
      :new_record? => true,
      :uri => "MyString"
    ))
  end

  it "renders new repository form" do
    render

    rendered.should have_selector("form", :action => repositories_path, :method => "post") do |form|
      form.should have_selector("input#repository_uri", :name => "repository[uri]")
    end
  end
end
