class Ride < ApplicationRecord
    belongs_to :user
    belongs_to :attraction

    # if user.tickets > attraction.tickets then allow, else say sorry
    # if user is too short, not allowed to ride ride
    # riding the rides subtracts the attraction ticket cost from user's tickets    
    def take_ride
        if enough_tickets? && tall_enough? # no tickets and short
            "Sorry." + ticket_error + height_error
        elsif enough_tickets?
            "Sorry." + ticket_error
        elsif tall_enough? 
            "Sorry." + height_error
        else
            have_fun # updates user tickets, nausea, and happiness with attraction ratings
        end

    end

    private
    def enough_tickets?
        self.user.tickets < self.attraction.tickets
    end

    def tall_enough?
        self.user.height < self.attraction.min_height
    end

    def have_fun
        self.user.update(
            :tickets => (self.user.tickets - self.attraction.tickets),
            :nausea => (self.user.nausea + self.attraction.nausea_rating),
            :happiness => (self.user.happiness + self.attraction.happiness_rating)
        )
    end

    def ticket_error
        " You do not have enough tickets to ride the #{self.attraction.name}."
    end

    def height_error
        " You are not tall enough to ride the #{self.attraction.name}."
    end
end
