Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # ↓トップページをルートパスとする
  root to: 'books#top'
  get 'about' => 'books#about'
  resources :books do
 end
  
 resources :users, only: [:show,:edit,:update,:index]
  
end
