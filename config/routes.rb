Rails.application.routes.draw do

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  controller :admin_login do
    get 'admin_login' => :new
    post 'admin_login' => :create
    delete 'admin_logout' => :destroy
  end

  controller :site do
    get 'landing' => :landing
    post 'landing' => :sending
  end

  resources :users, only: [:show, :new, :edit, :create, :update, :destroy]
  resources :groups, only: [:index, :new, :edit, :create, :update, :destroy]
  resources :messages, only: [:index, :new, :edit, :create, :update, :destroy]
  resources :comments, only: [:index, :new, :edit, :create, :update, :destroy]
  resources :admins, only: [:show, :edit, :update]
  resources :user_groups, only: [:new, :edit, :create,:update]
  resources :tasks, only: [:show, :new, :edit, :create, :update, :destroy]
  resources :key_words, only: [:new, :create, :destroy]
  resources :group_messager, only: [:new, :edit, :create, :update]
  resources :bots, only: [:new, :edit, :create, :update, :destroy]

  root 'site#landing'
  get 'activate_bot/activate'
  post 'refresh_part', to: 'tasks#refresh_part'
  post 'group_manage/group_leave_join'
end
