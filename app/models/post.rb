class Post < ApplicationRecord
  
  has_one_attached :post_image
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :searches, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  belongs_to :user
  
  def liked_by?(user)
    likes.exists?(user: user)
  end
  
  def self.search_by_keyword(keyword)
    where("title LIKE ? OR content LIKE ?", "%#{keyword}%", "%#{keyword}%")
  end

  def self.search_by_tag(tag_name)
    joins(:tags).where("tags.name = ?", tag_name)
  end

  def tag_names
    tags.map(&:name).join(', ')
  end

  def tag_names=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end
  
end
