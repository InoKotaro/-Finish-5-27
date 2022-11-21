class UsersController < ApplicationController
	 before_action :authenticate_user!, except: []

	def index
		@book= Book.new
		@user= current_user
		@users= User.all
	end

	def show
		@book= Book.new
		@user= User.find(params[:id])
		@books= @user.books
	end

	def edit
		@user= User.find(params[:id])
	end

	def update
		@user= User.find(params[:id])
		if @user.update(user_params)
			flash[:notice]= "You have updated user successfully."
			redirect_to user_path(@user)
		else
			render :edit
		end
	end

	private

	def user_params
    	params.require(:user).permit(:name, :profile_image, :introduction)
	end

	def authenticate_user
    user_id = params[:id].to_i
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to new_user_session_path
    end
	end
end