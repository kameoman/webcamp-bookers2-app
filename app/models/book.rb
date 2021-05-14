class Book < ApplicationRecord
  belongs_to :user
  # refileを使用するうえでのルールです。
  attachment :image
  # rails バリデーションの実装
  validates :title, presence: true
  validates :caption, presence: true
  
end
