class AccessToken < ApplicationRecord
  before_save :generate_token
  
  belongs_to :student

  def generate_token
    self.token = Digest::SHA256.hexdigest(student.first_name)
  end
end
