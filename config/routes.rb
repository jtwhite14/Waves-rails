Rails.application.routes.draw do
  
  root "home#index"

  devise_for :users
  resources :buoys
  resources :sessions


  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      devise_scope :user do
        match '/logins' => 'logins#create', :via => :post
        match '/logins' => 'logins#destroy', :via => :delete
        match '/registrations' => 'registrations#create', :via => :post
      end

      resources :users do
      	collection do
					get 'me'
				end
			end

      resources :waves do
      	member do 
      		get 'sessions'
      	end
      end
      
      resources :sessions
      resources :buoys
      resources :observations
    end
  end
end
