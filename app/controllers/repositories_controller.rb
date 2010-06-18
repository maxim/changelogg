class RepositoriesController < ApplicationController

  def new
    @repository = Repository.new
  end

  def create
    @repository = Repository.new(params[:repository])

    if @repository.save
      redirect_to(changelog_url(@repository), :notice => 'Repository was successfully created.')
    else
      render :action => "new"
    end
  end

end
