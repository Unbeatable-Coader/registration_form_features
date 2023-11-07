class AuthController < ApplicationController
    skip_before_action :authorized, only: [:login], :raise => false


    def login

    end


    def login_post
        name = params[:name]
        @user = User.find_by(name: name)
        password = params[:password]

        if @user.authenticate(password)
            payload = @user.id
            token = JsonWebToken.encode(payload)
            session[:user_token] = token
            render json: {
                token: token
            }, status: :accepted
        else
            render json: {message: 'Incorrect password'}, status: :unauthorized
        end

    end

    private 

    def login_params 
        params.permit(:name, :password)
    end

    def handle_record_not_found(e)
        render json: { message: "User doesn't exist" }, status: :unauthorized
    end
end
