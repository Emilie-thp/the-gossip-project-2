Rails.application.routes.draw do
  
  resources :cities
  
  resources :team
  
  resources :user
  
  resources :contact
  
  resources :welcome
  
  resources :gossips 
  
  resources :gossips do 
  	resources :comments 
  end
  
  resources :sessions, only:[:new, :create, :destroy]

end
