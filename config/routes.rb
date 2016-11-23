Rails.application.routes.draw do
  get 'cars/index'

  get 'cars/new'

  get 'cars/edit'

  get 'cars/show'

  get 'dealerships/index'

  get 'dealerships/new'

  get 'dealerships/edit'

  get 'dealerships/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
