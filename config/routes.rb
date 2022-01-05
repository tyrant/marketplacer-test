Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "application#index"

  get "cart" => "application#cart"

  resources :shopping_carts, only: :show do
    resources :cart_items, only: [:create, :destroy] do
      patch :increment
      patch :decrement
    end
  end
end
