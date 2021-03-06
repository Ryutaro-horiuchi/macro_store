class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_foods, through: :bookmarks, source: :food

  validates :name, presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-]+@[a-z\d\-]+\.[a-z]+\.*[a-z]*\z/
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  def bookmark(food)
    bookmark_foods << food
  end

  def unbookmark(food)
    bookmark_foods.destroy(food)
  end
end
