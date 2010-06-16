require 'spec_helper'

describe "repositories/show.html.erb" do
  before(:each) do
    assign(:repository, @repository = stub_model(Repository,
      :uri => "MyString"
    ))
  end

  it "renders attributes in <p>" do
    render
   rendered.should contain("MyString")
  end
end
