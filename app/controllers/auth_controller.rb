class AuthController < ApplicationController
    # skip_before_action :login, except: :login_post
    # before_action :authorize_request, except: :login_post
    before_action :current_user, only: [:login_post, :user_detail]
    helper_method :delete
    def login

    end

    def user_detail
    end

    def delete
        token = session[:user_token]
        user_info = JsonWebToken.decode(token)
        user_id = user_info[:name]
        if user_id
            @requested_user = User.find_by(name: user_id) 
        else
            @requested_user = nil
        end
        puts "requested user = #{@requested_user}"
        puts "current user = #{current_user}"
        if @current_user
            if current_user.id == @requested_user.id
                @requested_user.destroy
                redirect_to '/'
            else
                redirect_to login_path
            end
        else
            render json: {message: 'Please Log-in first'}
        end
    end


    def login_post
        name = params[:name]
        @user = User.find_by(name: name)
        password = params[:password]

        if @user&.authenticate(password)
            payload = {name: @user.name}
            token = JsonWebToken.encode(payload)
            session[:user_token] = token
            # render json: {
            #     token: token
            # }, status: :accepted
            # redirect_to '/user_detail'
                      
            redirect_to user_detail_path
        else
            render json: {message: 'Incorrect password'}, status: :unauthorized
        end
    # else
    #     render json: { message: 'User not found' }, status: :not_found
    # end

    end
    
    

    private 

    def login_params 
        params.permit(:name, :password)
    end

    def handle_record_not_found(e)
        render json: { message: "User doesn't exist" }, status: :unauthorized
    end

    def current_user
        token = session[:user_token]
        if token.present?
            user_info = JsonWebToken.decode(token)
            user_id = user_info[:name]
            if user_id
                @current_user = User.find_by(name: user_id) 
            else
                @current_user = nil
            end
        else
            @current_user = nil
        end
        @current_user
    end
end
