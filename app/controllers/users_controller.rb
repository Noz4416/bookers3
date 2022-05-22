class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @book =Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book)
    else
      @user = current_user
      @books = @user.books
      render :index
    end
  end

  def index
    @users = User.all
    @user = current_user
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      flash[:notice] = "Update to successfully"
      redirect_to user_path(user.id)
    else
      @user = user
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:name,:introduction,:profile_image)
  end

end
