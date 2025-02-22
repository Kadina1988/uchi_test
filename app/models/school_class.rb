class SchoolClass < ApplicationRecord
  self.table_name = "classes"

  has_many :students

  belongs_to :school
end
