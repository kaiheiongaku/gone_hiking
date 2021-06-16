Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :parks, only: :index
    end
  end
  match '*unmatched_route', :to => 'application#raise_not_found!', :via => :all
end
