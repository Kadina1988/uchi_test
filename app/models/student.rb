class Student < ApplicationRecord
  has_one :access_token, dependent: :destroy

  validates :first_name, :last_name, :surname, presence: true 

  belongs_to :school
  belongs_to :school_class, foreign_key: 'class_id'
end
