class StudentSerializer < ActiveModel::Serializer
  type 'data'

  attributes :id, :first_name, :last_name, :surname, :class_id, :school_id
end
