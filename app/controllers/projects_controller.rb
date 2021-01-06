class ProjectsController < ApplicationController
  def index
    @projects = Project.all
    @project = Project.new
  end

  def create
    @project = current_user.projects.new(project_params)
    respond_to do |format|
      if @project.save
        format.json { render json: {project: @project}, status: :ok }
      else
        format.json { render json: {messages: @project.errors.full_messages}, status: :unprocessable_entity }
      end
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :status)
  end
end
