Rails.application.routes.draw do
  get 'index', to: 'home#spa'
  get 'front_page', to: 'home#front_page'
end
