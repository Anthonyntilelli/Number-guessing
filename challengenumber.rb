# Generates random number for user ot guess
# Use "guess" method to attempt to find number
# Use "tell" method  to end game an get number
class ChallengeNumber
  attr_reader :min_num, :max_num, :trys, :win, :done

  def initialize(min_num = 0, max_num = min_num + 100)
    self.min_num = min_num
    self.max_num = max_num
    raise RangeError => "#{@min_num} < #{@max_num}" unless @min_num < @max_num
    @number = (@min_num + Random.rand(@max_num))
    @trys = 0
    @done = false
    @win = false
    # if done is true and win is false indicates game loss
  end

  def guess(integer)
    ensure_i(integer)
    @trys += 1 if @done == false
    compare = @number <=> integer
    if compare.zero? && !@done
      @done = true
      @win = true
    end
    compare
  end

  def tell
    # ends game with loss
    @done = true
    @number
  end

  private

  def ensure_i(integer)
    raise TypeError => 'Not an Integer' unless integer.is_a? Integer
  end

  def min_num=(integer)
    ensure_i(integer)
    @min_num = integer
  end

  def max_num=(integer)
    ensure_i(integer)
    @max_num = integer
  end
end

example = ChallengeNumber.new