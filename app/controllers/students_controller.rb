class StudentsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  skip_before_action :verify_authenticity_token

  before_action :find_class, only: %i[index]
  before_action :authorize, only: :destroy 

  def index 
    render json: @school_class.students, status: :ok
  end

  def create 
    student = Student.new(student_params)

    if student.valid?
      student.save
      json_student = student.as_json(except: [:created_at, :updated_at]) 
      
      token = student.build_access_token
      token.save
      
      render json: json_student, status: 201
    else 
      render json: {}, status: 405
    end
  end

  def destroy 
    student = Student.find(params[:id])
    student.destroy 
  end

  private 

  def not_found
    render json: {}, status: 400
  end

  def authorize
    provided_token = request.headers['X-Auth-Token']&.gsub(/\ABearer\s/, '')
    @access_token = AccessToken.find_by(token: provided_token)
    
    render json: {}, status: 401 if @access_token.nil? 
  end

  def student_params
    params.permit(:first_name, :last_name, :surname,
      :school_id, :class_id)
  end

  def find_class
    school = School.find(params[:school_id])
    @school_class = school.classes.find(params[:class_id])
  end
end
