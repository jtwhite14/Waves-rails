Rails.application.routes.draw do
  namespace :api do
  namespace :v1 do
    get 'users/me'
    end
  end

 devise_for :users
  resources :buoys
  resources :sessions


  namespace :api, :defaults => {:format => :json} do
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
    end
  end
end
