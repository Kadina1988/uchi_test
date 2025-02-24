FactoryBot.define do
  factory :student do
    first_name { "Вячеслав" }
    last_name { "Абдурахмангаджиевич" }
    surname { "Мухобойников" }
    association :school
    association :school_class 
  end
end
