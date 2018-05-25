module Schapi
    class Menu
        attr_accessor :breakfast, :lunch, :dinner

        def initialize(breakfast, lunch, dinner)
            @breakfast = breakfast
            @lunch = lunch
            @dinner = dinner
        end
    end
end