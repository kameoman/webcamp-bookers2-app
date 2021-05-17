class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    # ユーザのデータを1件取得し、インスタンス変数へ
    @user = User.find(params[:id])
    # ページングのpageメソッドを利用して、すべての投稿画像が表示されないように設定
    @book = Book.new


  end

  def after_log_in_path_for(resource)
    flash[:success] = "Signed in successfully."
    user_path(@user.id)
  end



  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
    redirect_to users_path(@user)
    end
  end

  def update
    @user = User.find(params[:id])
    if@user.update(user_params)
      flash[:notice] = "You have updated user successfully."
    redirect_to  user_path(params[:id])
    else
    render 'edit'
    end
  end

  # def limitation_correct_user
  #   unless @current_user.id == params[:id].to_i
  #   redirect_to books_path
  #   end
  # end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def ensure_correct_user
    @user = User.find_by(id: params[:id])
    if @user.id != current_user.id
    redirect_to users_path
    end
  end

end
