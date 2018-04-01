class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A.+@.+\.[a-z]+\z/i

  validates :username, presence: true, length: { minimum: 3, maximum: 50 },
            uniqueness: { case_sensitive: false }
  validates :email, presence: true, length: { minimum: 3, maximum: 50 },
            uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
end