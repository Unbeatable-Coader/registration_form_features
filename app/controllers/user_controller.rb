class UserController < ApplicationController
    
    # skip_before_action :verify_authenticity_token
    # before_action :user_detail, only: [:user_detail]
    
    rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record
    def new
        @user = User.new
    end

    def show
        @show = User.all

       render json: @show
    end

    def verify_authenticity_token
    end

    def index
      per_page = 10
      page = params[:page].to_i || 1
      offset = (page - 1) * per_page
      @user = User.limit(per_page).offset(offset)
  
      if @user.any?
        redirect_to  user_index_path(page: 0)
      end
    end


    def forgot_password
        
    end

  

    def encode_token
    end

    def create 
        @user = User.new(user_params)
        if @user.save
            token = encode_token()
            redirect_to login_path
        else
            puts "Validation errors: #{@user.errors.full_messages}"
            redirect_to '/'
        end
    end

    # def not_found
    #     render json: { error: 'not_found' }
    # end
    
    def authorize_request
    end

    private

    def user_params 
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def handle_invalid_record(e)
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end


end
