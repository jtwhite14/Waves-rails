Rails.application.routes.draw do
  root "home#index"
  
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
      
      resources :sessions do
        member do
          post 'upload'
        end
      end
      resources :buoys
      resources :observations
    end
  end

  # Admin views
  devise_for :admins
  resources :buoys do
    resources :observations
  end
  resources :wave_sessions
  resources :users
end
