Rails.application.routes.draw do
  resources :books do
    get :picture, on: :member
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
