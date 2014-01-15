class User < ActiveRecord::Base
  #CONSTANTS
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # relations
  has_many :entries, dependent: :destroy
  
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
