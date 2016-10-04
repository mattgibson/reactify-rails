Rails.application.routes.draw do
  get 'index', to: 'home#index'
  get 'front_page', to: 'home#front_page'
end
