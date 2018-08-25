class Book < ActiveRecord::Base
  belongs_to :user
  acts_as_taggable
  validates :author,  presence: true
  validates :title,   presence: true
  validates :user_id, presence: true
end
