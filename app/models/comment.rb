class Comment < ActiveRecord::Base
  # relations
  belongs_to :user
  belongs_to :entry

  # validations
  validates :content, presence:true
  validates :content, length: {maximum: 250}
  validates :entry_id, presence: true
  validates :user_id, presence: true

  # scopes
  default_scope -> { order('created_at DESC') }


  # methods
end
