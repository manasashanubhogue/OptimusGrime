#!/usr/bin/env ruby
class OptimusGrime
    def initialize(grid_size, coordinates)
      @grid_size = grid_size
      @coordinates = coordinates
    end
    
    def clean_instructions
        cur_pos_x, cur_pos_y = [0,0]
        grid_x, grid_y = @grid_size.split('x').map(&:to_i)
        navigation = []

        @coordinates.each do |coordinate|
            x, y = coordinate.scan(/\d+/).map(&:to_i)

            if coordinate_outside_grid?(x, y, grid_x, grid_y)
                puts "Error: Coordinate (#{x}, #{y}) is outside the grid size (#{grid_x}x#{grid_y})"
                return nil
            end

            # steps to be taken based on current position
            x_difference = x - cur_pos_x
            y_difference = y - cur_pos_y

            # traverse E/W based on the +/- step difference on X axis
            if x_difference > 0
                navigation.append("E"*x_difference)
            elsif x_difference < 0
                navigation.append("W"*x_difference.abs)
            end

            # traverse N/S based on the +/- step difference on Y axis
            if y_difference > 0
                navigation.append("N"*y_difference)
            elsif y_difference < 0
                navigation.append("S"*y_difference.abs)
            end
            navigation.append("C")

            # update current positon as ref point for next coordingate
            cur_pos_x = x
            cur_pos_y = y
        end
        navigation.join
    end

    def coordinate_outside_grid?(x, y, grid_x, grid_y)
        x < 0 || x >= grid_x || y < 0 || y >= grid_y
    end

end

 # extract the size & coordinates passed in the argument
grid_size, *coordinates = ARGV

# validate presence of the arguments
if grid_size && coordinates.any?
    optimus_grime = OptimusGrime.new(grid_size, coordinates)
    navigation = optimus_grime.clean_instructions
    puts navigation
else
    puts "Expected input: filename.rb grid_size \"coordinate1\" \"coordinate2\" "
end
