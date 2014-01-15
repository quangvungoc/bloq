class User < ActiveRecord::Base
  #CONSTANTS
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  
  # validations
  validates :email, confirmation: true
  validates :email, format: {with: VALID_EMAIL_REGEX}
  validates :email, presence: true
  validates :email, uniqueness: {case_sensitive: false}
                                    
  validates :email_confirmation, presence: true

  validates :name, length: {maximum: 50}
  validates :name, presence: true

  validates :password, length: {minimum: 6}


	has_secure_password
end
