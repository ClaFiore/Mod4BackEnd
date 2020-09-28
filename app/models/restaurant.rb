class Restaurant < ApplicationRecord
    has_many :tables

    def availableHours( date, party_size)
       
        openHours = [10, 11, 12, 13, 14, 17, 18, 19, 20, 21]
        availableHours =[]
        availableTables = []
        tables = self.tables.where("seats > #{party_size.to_i}")#5 tables
        
        openHours.each do |hr|
            tables.each do |table|
                if table.reservations.find_by(date: Date.parse(date), hour: hr) == nil
                    availableTables.push(table.id)
                end
            end
            if availableTables.length > 0
                availableHours.push(hr)
            end
            availableTables=[]
        end


        return availableHours
    end

end
