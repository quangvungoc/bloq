class Entry < ActiveRecord::Base
  # relations
  belongs_to :user
  has_many :comments, dependent: :destroy

  # validations
  validates :body, presence: true

  validates :title, length: {maximum: 250}
  validates :title, presence: true

  validates :user_id, presence: true

  # scopes
  default_scope -> { order('created_at DESC') }

  # methods
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                          WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end  
end
