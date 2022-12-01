class Book < ApplicationRecord

  belongs_to :user

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

end
