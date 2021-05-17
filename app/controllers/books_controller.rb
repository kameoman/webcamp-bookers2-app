class BooksController < ApplicationController
 before_action :ensure_correct_user, only: [:edit, :update]


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
    flash[:notice] = "You have created book successfully."
    else
    render :index
    end
  end


  def show
    @book_id = Book.find(params[:id])
    @user = @book_id.user
    @book = Book.new
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:success] = 'Book was successfully destroyed.'
    redirect_to books_path
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user.id != current_user.id
       redirect_to books_path
    end
  end


  def update
    @book = Book.find(params[:id])
    if@book.update(book_params)
     flash[:success] = 'Book was successfully updated.'
     redirect_to book_path(params[:id])
     flash[:notice] = "You have updated book successfully."
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

  def ensure_correct_user
    @book = Book.find_by(id: params[:id])
    if @book.user_id != current_user.id
    redirect_to books_path
    end
  end


end
