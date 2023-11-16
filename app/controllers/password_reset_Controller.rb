class PasswordResetController < ApplicationController
    def new 
    end
    def create
        @user = User.find_by(email: params[:email])

        if @user.present?
            PasswordMailer.with(user: @user).reset.deliver_now
        end
        redirect_to '/'
    end

    def edit
        @user = User.find_signed!(params[:token], purpose: "password_reset")
    rescue ActiveSupport::MessageVerifier::InvalidSignature
        redirect_to login_path, alert: "Your token has been expired, please try again later."
    end

    def update
        @user = User.find_signed!(params[:token], purpose: "password_reset")
        puts "user = #{@user}"
        if @user.update(password_params)
            redirect_to login_path, notice: "your password is reset successfully."
        else
            render :edit
        end
    end
 
    private
    def password_params
        params.require(:user).permit(:password, :password_confirmation)
    end
end