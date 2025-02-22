class School < ApplicationRecord
  has_many :classes, class_name: 'SchoolClass', foreign_key: 'school_id' 
  has_many :students 
end
