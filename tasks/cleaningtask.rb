#!/usr/bin/env ruby

Coordinate = Struct.new(:x, :y)

class CleaningTask

	attr_reader :grid_size, :coordinates

	NORTH = 'N'.freeze
	SOUTH = 'S'.freeze
	EAST = 'E'.freeze
	WEST = 'W'.freeze
	CLEAN = 'C'.freeze

	def initialize(grid_size, coordinates)
		@grid_size = grid_size
		@coordinates = coordinates.map { |c| validate_and_parse_coordinate(c) }
	end

	def validate_and_parse_coordinate(coordinate)
		# extract coordinates 
		unless coordinate =~ /^\(\d+, \d+\)$/
			raise ArgumentError, "Invalid coordinate format, should be of the format '(2, 3)'"
		end
		x, y = coordinate.scan(/\d+/).map(&:to_i)

		Coordinate.new(x, y)
	end

	def validate_and_parse_grid_size
		# extract the grid size along x & y axis
		grid_x, grid_y = grid_size.split('x').map(&:to_i)
		raise ArgumentError, "Invalid grid size: #{grid_size}, should be of the format XxY" if grid_x.nil? || grid_y.nil?

		[grid_x, grid_y]
	end
	
	def cleaning_instructions
		# Generates the cleaning instructions based on the grid size and coordinates
		cur_pos = Coordinate.new(0, 0)
		grid_x, grid_y = validate_and_parse_grid_size

		navigation = []

		@coordinates.each do |coordinate|

			if coordinate_outside_grid?(coordinate, grid_x, grid_y)
				raise StandardError, "Error: Coordinate (#{coordinate.x}, #{coordinate.y}) is outside the grid size (#{grid_x}x#{grid_y})"
			end

			# steps to be taken based on current position
			x_difference = coordinate.x - cur_pos.x
			y_difference = coordinate.y - cur_pos.y

			
			navigation << move_horizontally(x_difference)
			navigation << move_vertically(y_difference)
			navigation.append(CLEAN)

			# update current positon as ref point for next coordingate
			cur_pos = coordinate
		end

		navigation.join
	end

	def move_horizontally(difference)
		# traverse E/W based on the +/- step difference on X axis
		if difference.positive?
			EAST * difference
		elsif difference.negative?
			WEST * difference.abs
		end
	end

	def move_vertically(difference)
		# traverse N/S based on the +/- step difference on Y axis
		if difference.positive?
			NORTH * difference
		elsif difference.negative?
			SOUTH * difference.abs
		end
	end

	def coordinate_outside_grid?(coordinate, grid_x, grid_y)
		# ensure coordinates given are within the grid size and are not -ve as well
		coordinate.x < 0 || coordinate.x >= grid_x || coordinate.y < 0 || coordinate.y >= grid_y
	end

end
