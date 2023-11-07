class UserController < ApplicationController
    # skip_before_action :authorized, only: [:create]
    rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record
    def new
        @user = User.new
    end

    def show
        @show = User.all

       render json: @show
    end

    def create 
        @user = User.new(user_params)
        if @user.save
            token = encode_token(user_id: @user.id)
        else
            flash[:rgister_error] = @user.errors.full_messages
            redirect_to '/'
        end
    end

    def user2
        user_id = params[:id]
        requested_user = User.find_by(id: user_id)

        if requested_user
            if current_user.id == requested_user
                redirect_to '/user'
            else
                flash[:usr_error] = @user.errors.full_messages
                redirect_to '/'
            end
        else
            render json: {error: 'user not found'}, status: 400
        end
    end


    private

    def user_params 
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def handle_invalid_record(e)
            render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end

    def current_user
        token = session[:user_token]
        if token.present?
            user_info = JsonWebToken.decode(token)
            user_id = decoded_token[0]['user_id']
            @current_user ||= User.find_by(id: user_id)
        end
    end
end
