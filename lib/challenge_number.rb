# Generates random number for user ot guess
class ChallengeNumber
  attr_reader :min_num, :max_num

  def initialize(min_num = 0, max_num = min_num + 100)
    self.min_num = min_num
    self.max_num = max_num
    raise RangeError => "#{@min_num} < #{@max_num}" unless @min_num < @max_num
    @number = (@min_num + Random.rand(@max_num))
  end

  # TODO: Add Guess handling logic

  private

  def ensure_i(value)
    raise TypeError => 'Not an Integer' unless value.is_a? Integer
  end

  def min_num=(value)
    ensure_i(value)
    @min_num = value
  end

  def max_num=(value)
    ensure_i(value)
    @max_num = value
  end
end
