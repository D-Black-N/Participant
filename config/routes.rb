Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    registrations: 'users/registrations'}
  root to: 'users#index'
  get 'inform/view'
  get 'inform/add'
  get 'inform/create'
  get 'users/all'
  get 'users/index'
  delete 'users/destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
