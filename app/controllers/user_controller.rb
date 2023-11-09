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


    # def index
    #     @data_per_page = 10
    #     @page = params.fetch(:page,0).to_i
    #     puts "page = #{@page}"
    #     puts "DPP = #{@data_per_page}"
    #     @data = User.offset(@page * @data_per_page).limit(@data_per_page)
    # end
    def index
      page = params[:page].to_i || 1
      per_page = 10
      offset = (page - 1) * per_page
      user = User.limit(per_page).offset(offset)
  
      if user.any?
        render json: { data: user}
      end
    end
  

    def encode_token
    end

    def create 
        @user = User.new(user_params)
        if @user.save
            token = encode_token(user_id: @user.id)
        else
            # flash[:register_error] = @user.errors.full_messages
            redirect_to '/'
        end
    end

    def not_found
        render json: { error: 'not_found' }
    end
    
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
