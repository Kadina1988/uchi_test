class StudentsController < ApplicationController
  before_action :find_class 
  def index 
    render json: @school_class.students, status: :ok
  end

  private 

  def find_class
    school = School.find(params[:school_id])
    @school_class = school.classes.find(params[:class_id])
  end
end
