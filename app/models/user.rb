class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  def active_for_authentication?
    super && (is_delete == false)
  end

  def get_user_image(width, height)
    if avatar.attached?
      avatar.variant(resize: "#{width}x#{height}").processed
    else
      'no_image.jpg'
    end
  end


end
