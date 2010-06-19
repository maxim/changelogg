class ChangelogsController < ApplicationController
  def show
    @changelog = Changelog.new(Repository.find(params[:id]))
  end
end
