Rails.application.routes.draw do
  # get 'order/index'
  # get 'order/get_list'
  # get 'order/new'
  # post 'order/create'
  resources :order, only: [:index, :new, :create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
