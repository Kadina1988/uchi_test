require 'rails_helper' 

RSpec.describe ClassesController, type: :controller do 
  describe "GET /index" do
    let(:school) { create :school }
    let(:class_a) { create :school_class, school: school }
    
    before do 
      2.times do 
        create :student, school: school, class_id: class_a.id 
      end
    end
    
    subject { get :index, params: { school_id: school.id } }

    it 'should return status ok' do 
      subject 
      expect(response).to have_http_status(:ok)
    end

    it 'should return correct list of classes' do 
      subject 
      json = JSON.parse(response.body)
      expect(json["data"]).to eq([
        {
          "id" => class_a.id,
          "number" => class_a.number,
          "letter" => class_a.letter,
          "students_count" => 2
        }
      ])
    end
  end
end