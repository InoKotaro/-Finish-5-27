class BooksController < ApplicationController
  before_action :authenticate_user!, except: []

  def create
    @book= Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice]= "You have created book successfully."
      redirect_to book_path(@book)
    else
      @books= Book.all
      @user= current_user
      render :index
    end
  end

  def index
    @book= Book.new
    @books= Book.all
    @user= current_user
  end

  def show
    @book= Book.new
    @book_show= Book.find(params[:id])
    @user= @book_show.user
  end

  def edit
    @book= Book.find(params[:id])
  end

  def update
    @book= Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice]= "You have created book successfully."
      redirect_to book_path(@book)
    else
      @book= Book.find(params[:id])
      render :edit
    end
  end

  def destroy
    @book= Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def authenticate_user
    user_id = params[:id].to_i
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to new_user_session_path
    end
  end

end
