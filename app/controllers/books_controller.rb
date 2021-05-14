class BooksController < ApplicationController

  def new
    @book = Book.new

  end

  def top
  end

  def about

  end

  # createは、投稿データを保存するアクションメソッド
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    
    if@book.save
      flash[:success] = 'You have created book successfully.'
      redirect_to book_path(@book)
    else
      @books = Book.all
      flash.now[:danger] = 'error'
      render　books_path
    end
    
  end

  def index
    @books = Book.all
    @book = Book.new
    @users = User.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:success] = 'Book was successfully destroyed.'
    redirect_to books_path
  end

  def edit
    @book = Book.find(params[:id])
  end


  def update
    @book = Book.find(params[:id])
    if@book.update(book_params)
     flash[:success] = 'Book was successfully updated.'
     redirect_to book_path(params[:id])
    else
     flash.now[:danger] = 'error'
     render 'edit'
    end
  end

  # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title, :caption)
  end


end
