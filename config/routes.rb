Rails.application.routes.draw do
  resources :schools, only: %i[] do 
    resources :classes, only: :index do 
      resources :students, only: %i[index]
    end
  end

  resources :students, only: :create 
end
