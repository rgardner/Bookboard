class Book < ActiveRecord::Base
  belongs_to :booklist
  validates :author,       presence: true
  validates :title,        presence: true
  validates :booklist_id,  presence: true
end
