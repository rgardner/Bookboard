class Book < ActiveRecord::Base
  belongs_to :user
  validates :author,  presence: true
  validates :title,   presence: true
  validates :user_id, presence: true
end
