Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'orders#index'
  # get '/discounts', :to => redirect('/patch.js')
  # sawyermerchant.pagekite.me/discounts

  scope :api do
    scope :v1 do
      resources :orders do
        # :line_items
      end
      resources :acknowledgements
      resources :shipnotices
      resources :discounts, only: [:index]
      resources :orders, only: [:create]
      resources :woo_acknowledgements
      resources :woo_shipnotices
      resources :woo_orders, only: [:create]
      post '/update_woo_order', to: 'woo_orders#update_order', as: :update_woo_order
    end
  end

end
