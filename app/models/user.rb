class User < ActiveRecord::Base
  #CONSTANTS
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # relations
  has_many :entries, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  
  # validations
  validates :email, confirmation: true
  validates :email, format: {with: VALID_EMAIL_REGEX}
  validates :email, presence: true
  validates :email, uniqueness: {case_sensitive: false}
                                    
  validates :email_confirmation, presence: true

  validates :name, length: {maximum: 50}
  validates :name, presence: true

  validates :password, length: {minimum: 6}

  # callbacks
  before_save {self.email.downcase!}
  before_create :create_remember_token

  # others
	has_secure_password

  # methods
  def feed
    Entry.from_users_followed_by(self)
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy!
  end
  # these methods need to be changed to meet convention
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end
