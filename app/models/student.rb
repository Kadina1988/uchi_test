class Student < ApplicationRecord
  belongs_to :school
  belongs_to :school_class, class_name: 'SchoolClass', foreign_key: 'class_id'

  def class_id 
    school_class.id 
  end

  def class_id=(id)
    self.school_class.id = id 
  end
end
