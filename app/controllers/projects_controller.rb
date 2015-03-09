class ProjectsController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
  	@projects= current_user.projects
  	@on_projects=true
  end

  def show
  	@project=Project.find(params[:id])
  	@cards=@project.cards
  end

  def create
  	@project=Project.create(title: "Sweet New Project", user: current_user)
  	@project.cards.create(title: "First Card", body: "Oooh! This is exciting")
  	respond_to do |format|
  		format.html {redirect_to @project, notice: "new project added"}
  		format.js {redirect_to @project, notice: "new project added"}
  	end
  end

  def update
    @project = Project.find(params[:id])
    respond_to do |format|
      if @project.update_attributes(params.require(:project).permit(:title))
        format.html{redirect_to(@project, :notice => "Project was succesfully updated")}
        format.json{respond_with_bip(@project)}
      else
        format.html {render :action => "edit"}
        format.json {respond_with_bip(@project)}
      end
    end
  end


  def destroy
  	@project=Project.find(params[:id])
  	@project.destroy
  	respond_to do |format|
  		format.html {redirect_to projects_path, notice: "project deleted"}
  		format.js {head :no_content}
  	end
  end
end
