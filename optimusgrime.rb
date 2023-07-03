#!/usr/bin/env ruby
require_relative 'tasks/cleaningtask'

def process_arguments(arguments)
	if arguments.length >= 2
		grid_size = arguments[0]
		coordinates = arguments[1..]
		optimus_grime = CleaningTask.new(grid_size, coordinates)
		puts optimus_grime.cleaning_instructions
	else
		puts "Expected input: filename.rb grid_size \"coordinate1\" \"coordinate2\" "
		puts "Gridsize of the format 5x5 | Coordinate of the format \'(2, 3)\'"
	end
end

# Process command-line arguments
process_arguments(ARGV)