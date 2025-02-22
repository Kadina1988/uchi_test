FactoryBot.define do
  factory :school_class do
    number { 1 }
    letter { "А" }
    students_count { 32 }
    association :school 
  end
end
