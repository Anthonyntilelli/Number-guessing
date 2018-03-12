require 'minitest/autorun'
require 'minitest/spec'
require '../lib/challenge_number.rb'

describe 'ChallengeNumber method: #initialize: passing' do
  before do
    @min = 0
    @max = 100
    @under_test = ChallengeNumber.new(@min, @max)
  end

  it 'Ensure public getters and private setter with corect initial state' do
    # getters
    _(@under_test.min_num).must_equal @min
    _(@under_test.max_num).must_equal @max
    _(@under_test.tries).must_equal 0
    _(@under_test.win).must_equal nil
    # setter
    proc { @under_test.min_num = -1 }.must_raise NoMethodError
    proc { @under_test.max_num = 55 }.must_raise NoMethodError
    proc { @under_test.tries = 4 }.must_raise NoMethodError
    proc { @under_test.win = true }.must_raise NoMethodError
  end

  it 'hidden_number is valid' do
    proc { @under_test.hidden_number }.must_raise NoMethodError
    # make way to view hidden number
    def @under_test.minitest_hidden_number
      @hidden_number
    end
    _(@under_test.minitest_hidden_number.between?(@min, @max)).must_equal true
  end

  it 'hidden_number override is valid' do
    @under_test2 = ChallengeNumber.new(@min, @max, 55)
    # making way to view hidden number
    def @under_test2.minitest_hidden_number
      @hidden_number
    end
    _(@under_test2.minitest_hidden_number).must_equal 55
  end
end

# TODO: method initialize: failing
# TODO: TEST rest of methods
