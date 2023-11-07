Rails.application.routes.draw do
  get '/', to:'user#new'
  get '/user', to: 'user#new'

  post '/user', to: 'user#create'
 
  get '/login', to: 'auth#login'

  post '/login', to: 'auth#login_post'

  get '/user2', to: 'user#user2'
end
