class SchoolClassSerializer < ActiveModel::Serializer
  type 'data'
  
  attributes :id, :number, :letter, :students_count
end
