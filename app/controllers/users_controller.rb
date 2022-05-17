class UsersController < ApplicationController
  def show
    @user = User.new
    @books = @user.books
  end

  def edit
  end

  def index
    @user = User.find(params[:id])
    @books = @user.books
  end
  
  private
  
  def user_params
    params.require(:user).permit(:profile_image)
  end

end
