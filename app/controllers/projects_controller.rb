class ProjectsController < ApplicationController
  before_action :load_project, only: [:edit, :show, :update, :destroy]

  authorize_resource

  def index
    @projects = Project.order(id: :desc)
    @project = Project.new
    gon.admin = true
    gon.user_id = current_user.id
  end

  def create
    @project = current_user.projects.new(project_params)
    respond_to do |format|
      if @project.save
        format.json { render json: {project: @project, typejobs: @project.typejobs.map {|typejob| typejob.name }, status: @project.status.name }, status: :ok }
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

  def destroy
    @project.destroy
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :status_id, :typejob_ids => [])
  end

  def load_project
    @project = Project.find(params[:id])
  end
end
