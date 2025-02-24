FactoryBot.define do
  factory :school_class do
    number { 1 }
    letter { "А" }
    association :school 
  end
end
