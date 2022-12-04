class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]


  def new
    @book = Book.new
  end

  def index
    @books = Book.all
    @user = current_user
    @new_book = Book.new
  end

  def create
    book = Book.new(book_params)
    book.user_id = current_user.id
    if book.save
      flash[:notice] = "Created book successfully"
      redirect_to book_path(book.id)
    else
      @new_book = book
      @user = current_user
      @book = @user.books
      @books = Book.all
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
    @user = @book.user
    @new_book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end

  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      flash[:notice] = "Update book successfully"
      redirect_to book_path(book.id)
    else
      @book = book
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end


  private

  def book_params
    params.require(:book).permit(:title,:body)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end

end
