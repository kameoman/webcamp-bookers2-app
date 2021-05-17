class UsersController < ApplicationController
  def show
    # ユーザのデータを1件取得し、インスタンス変数へ
    if@user = User.find(params[:id])
    # ページングのpageメソッドを利用して、すべての投稿画像が表示されないように設定
    flash[:success] = 'Welcome! You have signed up successfully.'
    @users = User.all
    end
  end

  def index
    @users = User.all
    @user = User.new
    @books = Book.all
    @book = current_user
  end
  
  def edit
    @user = User.find(params[:id])
    @book = Book.new(book_params)

  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to book_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
