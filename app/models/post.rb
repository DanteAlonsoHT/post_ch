class Post < ApplicationRecord
  belongs_to :user
  validates :title, :body, presence: true

  scope :with_user_email, -> { joins(:user).select('posts.*, users.email AS user_email') }
end
