require 'spec_helper'

describe RepositoriesController do

  def mock_repository(stubs={})
    @mock_repository ||= mock_model(Repository, stubs).as_null_object
  end

  describe "GET show" do
    it "assigns the requested repository as @repository" do
      Repository.stub(:find).with("37") { mock_repository }
      get :show, :id => "37"
      assigns(:repository).should be(mock_repository)
    end
  end

  describe "GET new" do
    it "assigns a new repository as @repository" do
      Repository.stub(:new) { mock_repository }
      get :new
      assigns(:repository).should be(mock_repository)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created repository as @repository" do
        Repository.stub(:new).with({'these' => 'params'}) { mock_repository(:save => true) }
        post :create, :repository => {'these' => 'params'}
        assigns(:repository).should be(mock_repository)
      end

      it "redirects to the created repository" do
        Repository.stub(:new) { mock_repository(:save => true) }
        post :create, :repository => {}
        response.should redirect_to(repository_url(mock_repository))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved repository as @repository" do
        Repository.stub(:new).with({'these' => 'params'}) { mock_repository(:save => false) }
        post :create, :repository => {'these' => 'params'}
        assigns(:repository).should be(mock_repository)
      end

      it "re-renders the 'new' template" do
        Repository.stub(:new) { mock_repository(:save => false) }
        post :create, :repository => {}
        response.should render_template("new")
      end
    end

  end

end
