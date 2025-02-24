class SchoolClass < ApplicationRecord
  self.table_name = "classes"

  has_many :students, foreign_key: 'class_id'

  belongs_to :school

  validates :number, :letter, presence: true  

  def students_count
    students.count 
  end
end
