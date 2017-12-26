class Restaurant < ApplicationRecord
  mount_uploader :image, PhotoUploader
  validates_presence_of :name
  
  belongs_to :category, optional: true

  # 當 Restaurant 物件被刪除時，順便刪除依賴的 Comment
  has_many :comments, dependent: :destroy

  # 「餐廳被很多使用者收藏」的多對多關聯
  # 將關聯名稱自訂為 :favorited_users
  # 自訂名稱後，Rails 無法自動推論來源名稱，需另加 source 告知 model name
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  # 「餐廳被很多使用者喜歡」的多對多關聯
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  def is_favorited?(user)
    self.favorited_users.include?(user)
  end

  def is_liked?(user)
    self.liked_users.include?(user)
  end

  def count_favorites
    self.favorites_count = self.favorites.size
    self.save
  end

end
