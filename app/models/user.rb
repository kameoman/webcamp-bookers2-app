class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # ↓Userモデルにbookモデルを関連付ける
 has_many :books, dependent: :destroy
 
 attachment :profile_image
 
 validates :name, uniqueness: true, presence: true,length: {minimum: 2,maximum: 20 }
# validates :introduction, presence: true,length: {maximum: 50 }

 def books
   Book.where(user_id: self.id)
 end
 
  def email_required?
    false
  end

  def email_changed?
    false
  end
  
end
