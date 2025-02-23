class Student < ApplicationRecord
  belongs_to :school
  belongs_to :school_class, foreign_key: 'class_id'
end
