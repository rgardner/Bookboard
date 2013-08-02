class Booklist < ActiveRecord::Base
  belongs_to :user
  has_many :books
  validates :title,   presence: true, length: { maximum: 60 }
  validates :user_id, presence: true
end
