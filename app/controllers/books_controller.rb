class BooksController < ApplicationController

  def new
    @book = Book.new

  end

  def top
  end

  def about

  end

  def index
    @books = Book.all
    @book = Book.new
    @book.user = current_user
  end



  # createは、投稿データを保存するアクションメソッド
  def create
    @books = Book.all
    @book = Book.new(book_params)
    @book.user = current_user
    if@book.save
    redirect_to book_path(@book)
    else
    render :index
    end
  end


  def show
    @book = Book.find(params[:id])
    @user = @book.user
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
    params.require(:book).permit(:title, :body)
  end


end
