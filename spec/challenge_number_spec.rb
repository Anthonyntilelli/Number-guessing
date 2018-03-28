require_relative '../lib/challenge_number.rb'
RSpec.describe 'ChallengeNumber ' do
  describe '#initialize' do
    context 'when initialize' do
      subject( :valid ) { ChallengeNumber.new(0, 100) }
      it "create new game with valid range" do
        expect(valid.min_num).to eql(0)
        expect(valid.max_num).to eql(100)
        expect(valid.tries).to eql(0)
        expect(valid.win).to eql(nil)
      end
      it 'raise error on invalid input' do
        expect { _invalid_arg = ChallengeNumber.new(0, 'invalid') }.to raise_error(TypeError)
        expect { _invalid_arg = ChallengeNumber.new(0, 100, 'invalid') }.to raise_error(TypeError)
        expect { _invalid_range = ChallengeNumber.new(0, -5)}.to raise_error(RangeError)
      end
    end
  end
end

# guess
# tell
# new_game!
# convert_integer
