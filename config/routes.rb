Rails.application.routes.draw do
  get '/' => 'home#top'
  get 'home/rule'
  get 'users/setting'
  post 'users/setting_create'
  get 'users/start'
  get 'users/finish'
  get 'users/kill'
  get 'users/result'
  get 'users/record'
  get 'users/not_seen/:num' => 'users#not_seen', as: 'users_not_seen'
  get 'users/subject/:num' => 'users#subject', as: 'users_subject'
  get 'users/vote/:num' => 'users#vote', as: 'users_vote'
  post 'users/vote_create/:num' => 'users#vote_create', as: 'users_vote_create'
  delete 'users/destroy_selected/:id' => 'users#destroy_selected', as: 'users_destroy_selected'
  delete 'users/destroy_all'
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
