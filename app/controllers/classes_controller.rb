class ClassesController < ApplicationController
  before_action :find_school
  def index 
    render json: @school.classes, status: :ok
  end

  private 

  def find_school
    @school = School.find(params[:school_id]) 
  end
end
