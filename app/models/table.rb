class Table < ApplicationRecord
    has_many :reservations
    has_many :users, through: :reservations
    belongs_to :restaurant
end
