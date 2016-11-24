Rails.application.routes.draw do
  # get 'cars/index'
  #
  # get 'cars/new'
  #
  # get 'cars/edit'
  #
  # get 'cars/show'

  root 'dealerships#index'

  # get 'dealerships/new'
  #
  # get 'dealerships/edit'
  #
  # get 'dealerships/show'

  resources :dealerships do
    resources :cars
  end
end
