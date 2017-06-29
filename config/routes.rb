Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'orders#index'

  scope :api do
    scope :v1 do
      resources :orders
    end
  end

end