class StudentsController < ApplicationController
  before_action :find_class, only: %i[index]
  def index 
    render json: @school_class.students, status: :ok
  end

  def create 
    # debugger
    student = Student.new(student_params)
    if student.valid?
      student.save 
      render json: student, status: :created 
    end
  end

  private 

  def student_params
    params.permit(:first_name, :last_name, :surname,
      :school_id, :class_id)
  end

  def find_class
    school = School.find(params[:school_id])
    @school_class = school.classes.find(params[:class_id])
  end
end
