require 'rspec'

require_relative 'optimusgrime'

RSpec.describe "OptimusGrime" do
    describe "#clean_instructions" do
      context "with valid input" do
        let(:grid_size) { '5x5' }
        let(:coordinates) { ['(1, 3)'] }
        let(:optimus_grime) { OptimusGrime.new(grid_size, coordinates) }

        it 'returns the correct navigation instructions for single coordinate' do
          expect(optimus_grime.clean_instructions).to eq('ENNNC')
        end

        it 'returns the correct navigation instructions for multiple coordinates' do
          coordinates = ['(1, 3)', '(2, 4)', '(0, 2)']
          optimus_grime = OptimusGrime.new(grid_size, coordinates)
          expect(optimus_grime.clean_instructions).to eq('ENNNCENCWWSSC')
        end
      end
      
      context "with invalid input" do
        let(:grid_size) { '3x3' }
        let(:coordinates) { ['(6, 3)'] }
        let(:optimus_grime) { OptimusGrime.new(grid_size, coordinates) }

        it 'returns nil and displays error for coordinates outside grid size' do
          expect { optimus_grime.clean_instructions }.to output(/Error: Coordinate \(6, 3\) is outside the grid size \(3x3\)/).to_stdout
          expect(optimus_grime.clean_instructions).to be_nil
        end
      end
    end
end
