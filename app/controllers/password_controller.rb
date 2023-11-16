# class PasswordController < ApplicationController
#     before_action :current_user, only: [:login_post, :user_detail]

#     def edit 
#     end


#     def update
#         password = params[:password_digest]
#         puts "password = #{password}"
#         if password.update(password_params)
#             puts "current user = #{@current_user}"
#             redirect_to user_path, notice: "Password Updated"
#         else
#             render password_path
#         end

#     end


#     private
#     def password_params
#         params.permit(:password_digest, :password_confirmation)
#     end

#     def current_user
#         token = session[:user_token]
#         if token.present?
#             user_info = JsonWebToken.decode(token)
#             user_id = user_info[:password_digest]
#             if user_id
#                 @current_user = User.find_by(name: user_id) 
#             else
#                 @current_user = nil
#             end
#         else
#             @current_user = nil
#         end
#         @current_user
#     end
# end