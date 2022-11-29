class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books,dependent: :destroy
  # フォローした、されたの関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 一覧画面での表示用
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :relationships, source: :follower

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: {minimum: 2, maximum: 20}
  validates :introduction, length: {maximum: 50}


  has_one_attached:profile_image

  def get_profile_image(width,height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      profile_image.attach(io:File.open(file_path),filename: 'no_image.jpeg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit:[width,height]).processed
  end

end
