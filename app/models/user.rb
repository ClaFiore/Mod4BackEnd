class User < ApplicationRecord
    has_many :reservations
    has_many :tables, through: :reservations
    has_secure_password
    validates :username, presence: true, uniqueness: {case_sensitive: false}
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true, uniqueness: {case_sensitive: false}
    validates :first_name, presence: true
    validates :last_name, presence: true
end
