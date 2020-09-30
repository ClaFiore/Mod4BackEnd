class Reservation < ApplicationRecord
    belongs_to :user
    belongs_to :table
    validates :user_id, presence: true
    validates :table_id, presence: true
    validates :party, presence: true
    validates :date, presence: true, if: :date_after_current?
    validates :hour, presence: true

    def date_after_current?
        date >= Date.today
    end

    

end
