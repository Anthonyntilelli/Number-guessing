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
        expect { invalid_arg = ChallengeNumber.new(0, 'invalid') }.to raise_error(TypeError)
        expect { invalid_arg = ChallengeNumber.new(0, 100, 'invalid') }.to raise_error(TypeError)
        expect { invalid_range = ChallengeNumber.new(0, -5)}.to raise_error(RangeError)
      end
    end
  end
  describe '#guess' do
    context 'when provided a higher number' do
      subject( :higher_tester ) { ChallengeNumber.new(0, 50, 25) }
      it 'returns -1, tries == -1 and win == nil' do
	 expect(higher_tester.guess('49')).to eql(-1)
	 expect(higher_tester.win).to eql(nil)
	 expect(higher_tester.tries).to eql(1)
      end
    end
    context 'when provided a lower number' do
      subject( :lower_tester ) { ChallengeNumber.new(0, 50, 25) }
      it 'returns 1, tries == 1 and win == nil' do
	 expect(lower_tester.guess(1)).to eql(1)
	 expect(lower_tester.win).to eql(nil)
	 expect(lower_tester.tries).to eql(1)
      end
    end
    context 'when provided correct number' do
      subject( :tester ) { ChallengeNumber.new(0, 100, 50) }
      it 'return returns 0 and win == true' do
        expect(tester.guess('50')).to eql(0)
	expect(tester.win).to eql(true)
      end
    end
    context 'when provided invalid number' do
      subject( :invalid_tester ) { ChallengeNumber.new(0, 100, 50) }
      it 'return returns false tries ==0 and win == nil' do
        expect(invalid_tester.guess('999')).to eql(false)
        expect(invalid_tester.guess('BATMAN')).to eql(false)
	expect(invalid_tester.win).to eql(nil)
	expect(invalid_tester.tries).to eql(0)
      end
    end
  end
end

# tell
# new_game!
# convert_integer
