require 'spec_helper'

describe ChangelogsController do

  def mock_repository(stubs={})
    @mock_repository ||= mock_model(Repository, stubs).as_null_object
  end

  def mock_changelog(stubs={})
    @mock_changelog ||= mock_model(Changelog, stubs).as_null_object
  end

  describe "GET show" do
    it "assigns the requested changelog as @changelog" do
      Repository.stub(:find).with("37") { mock_repository }
      Changelog.stub(:new).with(mock_repository) { mock_changelog }
      get 'show', :id => "37"
      assigns(:changelog).should be(mock_changelog)
      response.should be_success
    end
  end

end
