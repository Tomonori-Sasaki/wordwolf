Rails.application.routes.draw do
  get 'users/new'
  get 'users/create'
  get 'users/player/:num' => 'users#player'
  get 'users/create_player'
  get '/' => 'home#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
