require 'rails_helper'

RSpec.describe AccessToken, type: :model do
  describe '#create' do 
    let(:student) { create :student }

    it 'token should not be empty' do 
      access_token = student.build_access_token
      access_token.save 
      expect(access_token.token).not_to be_empty
    end
  end
end
