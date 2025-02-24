require 'rails_helper' 

RSpec.describe StudentsController, type: :controller do 
  let(:school) { create :school }
  let(:class_1) { create :school_class, school: school }
  
  describe "GET #index" do
    let!(:student) { create :student, school: school, class_id: class_1.id }
    let!(:student_2) { create :student, school: school, class_id: class_1.id, first_name: 'Сергей' }

    subject { get :index, params: { school_id: school.id, class_id: class_1.id } }

    it 'should return status ok' do 
      subject 
      expect(response).to have_http_status(:ok)
    end
    
    it 'should return correct list of students' do 
      subject 
      json = JSON.parse(response.body)
      
      Student.all.each_with_index do |s, i|
        expect(json["data"][i]).to eq(
          {
            "id" => s.id,
            "first_name" => s.first_name,
            "last_name" => s.last_name,
            "surname" => s.surname,
            "class_id" => s.class_id,
            "school_id" => s.school_id
          }
        )
      end
    end
  end

  describe "POST create" do 
    context 'when valid input' do 
      let(:correct_params) do 
        {
          first_name: 'John',
          last_name: 'Doe', 
          surname: 'Michal',
          school_id: school.id, 
          class_id: class_1.id
        }
      end

      subject { post :create, params: correct_params }

      it 'should return status 201' do
        subject 
        expect(response).to have_http_status(201)
      end
      
      it 'should return attributes' do
        subject 
        json = JSON.parse(response.body)
        expect(json).to eq(
          {
            "id" => Student.last.id, 
            "first_name" => correct_params[:first_name],
            "last_name" => correct_params[:last_name], 
            "surname" => correct_params[:surname],
            "school_id" => correct_params[:school_id],
            "class_id" => correct_params[:class_id]
          }
        )
      end

      it 'should create access_token' do 
        expect { subject }.to change { AccessToken.all.count }.by(1)
      end

      it 'should change count of students' do 
        expect { subject }.to change { Student.all.count }.by(1)
      end
    end

    context 'when invalid input' do 
      let(:invalid_params) do 
        {
          first_name: 'John',
          last_name: 'Doe', 
          surname: 'Michal'
        }
      end

      subject { post :create, params: invalid_params }
      it 'should return status 405' do 
        subject
        expect(response).to have_http_status(405)
      end
    end
  end

  describe "DELETE #destroy" do 
    let(:student) { create :student }
    
    context 'when unauthorized' do 
      before { request.headers['X-Auth-Token'] = 'Invalid token' }

      it 'should return status 401' do 
        delete :destroy, params: { id: student.id }
        expect(response).to have_http_status(401)
      end
    end
    
    context 'when authorized' do 
      let(:access_token) { create :access_token, student: student }
      
      before { request.headers['X-Auth-Token'] = "Bearer #{access_token.token}" }
      
      context 'when incorrect id' do 
        it 'should return code 400' do 
          delete :destroy, params: { id: -44 }
          expect(response).to have_http_status(400)      
        end
      end

      context 'when operation was successful' do 
        before { student }
        it 'should change count of studennts' do
          expect { delete :destroy, params: {id: student.id} }.to change { Student.all.count }.by(-1)
        end
      end
    end
  end
end