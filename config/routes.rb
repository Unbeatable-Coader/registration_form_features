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

end
