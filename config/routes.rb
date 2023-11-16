Rails.application.routes.draw do
  get '/', to:'user#new'
  # get '/user', to: 'user#new'

  post '/user', to: 'user#create'
 
  get '/login', to: 'auth#login'

  post '/login', to: 'auth#login_post'

  # get '/user/get/:id', to: 'user#user_detail'

  get '/user_detail', to: 'auth#user_detail'
  post '/user_detail', to: 'auth#user_detail'

  # delete '/delete', to: 'auth#delete'
  delete '/user', to: 'auth#delete'
  delete '/delete/:name', to: 'auth#delete', as: 'delete'

  # get '/index/:page', to: 'user#index'

  get '/user/index/:page', to: 'user#index'
  # config/routes.rb


  get '/password', to: 'user#show'

  get 'password/reset', to: 'password_reset#new'
  post 'password/reset', to: 'password_reset#create'
  get 'password/reset/edit', to: 'password_reset#edit'
  patch 'password/reset/edit', to: 'password_reset#update'

  get '/reset', to: 'passwordmailer#reset'

  get '/upload', to: 'uploadimg#new'
  post '/upload', to: 'uploadimg#create'

  get '/uploaded', to: 'uploadimg#show'

  resources :uploadimg, only: [:new, :create]
  get '/uploaded_images/:filename', to: 'uploadimg#show', as: :uploaded_image
end
