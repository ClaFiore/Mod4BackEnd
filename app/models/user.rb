class User < ApplicationRecord
    has_many :reservations
    has_many :tables, through: :reservations
    has_secure_password
end
