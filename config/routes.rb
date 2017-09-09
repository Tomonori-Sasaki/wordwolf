Rails.application.routes.draw do
  get '/' => 'home#top'
  get 'users/setting'
  post 'users/setting_create'
  get 'users/not_seen'
  delete 'users/destroy_all'
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
