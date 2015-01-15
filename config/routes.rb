Rails.application.routes.draw do
  

  devise_for :users
  resources :buoys
  resources :sessions


  namespace :api, :defaults => {:format => :json} do
    devise_scope :user do
        match '/logins' => 'logins#create', :via => :post
        match '/logins' => 'logins#destroy', :via => :delete
        match '/registrations' => 'registrations#create', :via => :post
      end
    namespace :v1 do
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
