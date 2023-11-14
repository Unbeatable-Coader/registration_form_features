class PasswordMailer < ApplicationMailer
  def reset
    @token = params[:user].signed_id(purpose: "password_reset", expires_in: 1.hour)

    mail to: params[:user].email
  end
end
