class ProjectsController < ApplicationController
  before_action :load_project, only: [:edit, :show, :update]

  authorize_resource

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

  def show; end

  def edit; end

  def update
    if @project.update(project_params)
      redirect_to root_path, notice: "Project #{@project.title} has been update"
    else
      flash.now[:alert] = "Project #{@project.title} has not been update"
      render :edit
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :status)
  end

  def load_project
    @project = Project.find(params[:id])
  end
end
