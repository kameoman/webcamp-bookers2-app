class ApplicationController < ActionController::Base
  before_action :authenticate_user!,except: [:top, :about]
  # protect_from_forgery with: :null_session
  skip_forgery_protection
  # ログイン認証が成功していないと、トップページ以外の画面（ログインと新規登録は除く）は表示できない仕様

  before_action :configure_permitted_parameters, if: :devise_controller?


  def after_sign_in_path_for(resource)
    user_path(@user.id)
  end

  def after_sign_out_path_for(resource)
    root_path

  end

  protected
  def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

  def about
    @books = Book.all
    @book = Book.new
  end

end

Refile.secret_key = '3eeff8a34ff35c1f0dbee8b17997779a689d9ff113b0a6b8db1592db329d4c1bb78bed216048db97d15e14110257c202ee7a7b095e00ce3e9e24cc9c0deb540b'
