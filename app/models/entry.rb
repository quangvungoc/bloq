class Entry < ActiveRecord::Base
  # relations
  belongs_to :user

  # validations
  validates :body, presence: true

  validates :title, length: {maximum: 250}
  validates :title, presence: true

  validates :user_id, presence: true

  # scopes
  default_scope -> { order('created_at DESC') }
end
