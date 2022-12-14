class Book < ApplicationRecord

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  validates :body, length: {maximum: 200 }

  # 検索方法分岐
  def self.looks(search,word)
    if search == "perfect"
      @book = Book.where("title LIKE?", "#{word}")
    elsif search == "forword"
      @book = Book.where("title LIKE?", "#{word}%")
    elsif search == "backword"
      @book = Book.where("title LIKE?", "%#{word}")
    elsif search == "partial"
      @book = Book.where("title LIKE?", "%#{word}%")
    else
      @book = Book.all
    end
  end
  # ログインユーザーがいいねをしているかを判断
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
