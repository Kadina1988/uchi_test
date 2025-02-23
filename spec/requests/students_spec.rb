require 'rails_helper'

RSpec.describe "Students", type: :request do
  let(:school) { create :school }
  let(:class_1) { create :school_class, school: school }
  
  describe "GET index" do
    let!(:student) { create :student, school: school, school_class: class_1 }
    let!(:student_2) { create :student, school: school, school_class: class_1, first_name: 'Сергей' }

    subject { get "/schools/#{school.id}/classes/#{class_1.id}/students"}

    it 'should return status ok' do 
      subject 
      expect(response).to have_http_status(:ok)
    end
    
    it 'should return correct list of students' do 
      subject 
      json = JSON.parse(response.body)

      Student.all.each_with_index do |s, i|
        expect(json["data"][i]).to eq({
          "id" => s.id,
          "first_name" => s.first_name,
          "last_name" => s.last_name,
          "surname" => s.surname,
          "class_id" => s.class_id,
          "school_id" => s.school_id
        })
      end
    end
  end

  describe "POST create" do 
    let(:correct_params) do 
      {
        first_name: 'John',
        last_name: 'Doe', 
        surname: 'Michal',
        school_id: school.id, 
        class_id: class_1.id
      }
    end

    subject { post '/students', params: correct_params }

    it 'should return status 201' do
      subject 
      # debugger
      expect(response).to have_http_status(201)
    end

    it 'should return attributes' do
      subject 
      expect(json).to eq(
        correct_params
      )
    end

    it 'should change count of Students' do 
      expect { subject }.to change { Student.all.count }.by(1)
    end
  end
end
