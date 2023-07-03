require 'rspec'

require_relative '../tasks/cleaningtask'


RSpec.describe "CleaningTask" do
	describe '#validate_and_parse_coordinate' do
		let(:coordinate) { '(2, 3)'}
		let(:cleaning_task) { CleaningTask.new('5x5', [coordinate]) }

		context 'with valid coordinate format' do
			it 'returns the correct Coordinate object' do
				expected_result = Coordinate.new(2, 3)
				expect(cleaning_task.validate_and_parse_coordinate(coordinate)).to eq(expected_result)
			end
		end

		context 'with invalid coordinate format' do
			it 'raises an ArgumentError' do
				coordinate = '(2,3())'
				expect { cleaning_task.validate_and_parse_coordinate(coordinate) }.to raise_error(ArgumentError, "Invalid coordinate format, should be of the format '(2, 3)'")
			end
		end
	end

	describe '#validate_and_parse_grid_size' do
		let(:grid_size) { '5x5' }
		let(:cleaning_task) { CleaningTask.new(grid_size, []) }

		context 'with valid grid size' do
			it 'returns the correct grid size' do
				expected_result = [5, 5]
				expect(cleaning_task.validate_and_parse_grid_size).to eq(expected_result)
			end
		end

		context 'with invalid grid size format' do
			let(:grid_size) { '5x' }
			it 'raises an ArgumentError' do
				expect { cleaning_task.validate_and_parse_grid_size }.to raise_error(ArgumentError, "Invalid grid size: #{grid_size}, should be of the format XxY")
			end
		end
	end

	describe '#cleaning_instructions' do
		let(:grid_size) { '5x5' }
		let(:cleaning_task) { CleaningTask.new(grid_size, coordinates) }

		context 'with valid input' do
			before do
				@instructions = cleaning_task.cleaning_instructions
			end

			context 'for a single coordinate' do
				let(:coordinates) { ['(1, 3)'] }

				it 'returns the correct navigation instructions' do
					expect(@instructions).to eq('ENNNC')
				end
			end

			context 'for multiple coordinates' do
				let(:coordinates) { ['(1, 3)', '(2, 4)', '(0, 2)'] }

				it 'returns the correct navigation instructions' do
					expect(@instructions).to eq('ENNNCENCWWSSC')
				end
			end

			context 'for coordinates at grid boundaries' do
				let(:coordinates) { ['(0, 0)'] }

				it 'returns the correct navigation instructions' do
					expect(@instructions).to eq('C')
				end
			end
		end

		context 'with invalid input' do
			context 'with coordinates outside grid size' do
				let(:coordinates) { ['(6, 3)'] }

				it 'raises an exception' do
					expect { cleaning_task.cleaning_instructions }.to raise_error(StandardError, /Error: Coordinate \(6, 3\) is outside the grid size \(#{grid_size}\)/)
				end
			end

			context 'with empty coordinates' do
				let(:coordinates) { [] }

				it 'returns an empty string when there are no coordinates' do
					expect(cleaning_task.cleaning_instructions).to eq('')
				end
			end

			context 'with invalid coordinate format' do
				let(:coordinates) { ['(5,2,(2))'] }

				it 'raises an exception' do
					expect { cleaning_task.cleaning_instructions }.to raise_error(ArgumentError, "Invalid coordinate format, should be of the format '(2, 3)'")
				end
			end

			context 'with invalid grid size' do
				let(:coordinates) { ['(6, 6)'] }
				let(:grid_size) { '5x' }

				it 'raises an exception' do
					expect { cleaning_task.cleaning_instructions }.to raise_error(ArgumentError, "Invalid grid size: #{grid_size}, should be of the format XxY")
				end
			end
		end
	end
end

RSpec.describe "Command-line arguments" do

	it "displays an error message when arguments are missing" do
		output = `ruby optimusgrime.rb`
		expect(output).to include("Expected input: filename.rb grid_size \"coordinate1\" \"coordinate2\"")
	end

	it "displays an error message when one of the arguments is missing" do
		output = `ruby optimusgrime.rb 5x5`
		expect(output).to include("Expected input: filename.rb grid_size \"coordinate1\" \"coordinate2\"")
	end

end
