class ProjectsController < ApplicationController
  def index
    @projects = Project.all
    @project = Project.new
  end

  # def new
  #   @project = Project.new
  # end

  def create
    @project = current_user.projects.new(project_params)
    if @project.save
      redirect_to projects_path
    else
      @projects = Project.all
      render :index
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :status)
  end
end
