class StudentsController < ApplicationController
  before_action :find_class, only: %i[index]
  def index 
    render json: @school_class.students, status: :ok
  end

  def create 
    student = Student.new(student_params)
    # debugger
    if student.valid?
      student.save
      json_student = student.as_json(except: [:created_at, :updated_at]) 
      render json: json_student, status: 201
    else 
      render json: {}, status: 405
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
