# Generates random number for user ot guess
# Use "guess" method to attempt to find number
# Use "tell" method  to end game an get number
class ChallengeNumber
  attr_reader :min_num, :max_num, :trys, :win, :done

  def initialize(min_num, max_num)
    self.min_num = min_num
    self.max_num = max_num
    raise RangeError => "#{@min_num} < #{@max_num}" unless @min_num < @max_num
    new!
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

  def new!
    @number = (@min_num + Random.rand(@max_num))
    @trys = 0
    @done = false
    @win = false
    # if done is true and win is false indicates game loss
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

# Game start
MIN = 0
MAX = 100
MIN.freeze
MAX.freeze
game = ChallengeNumber.new(MIN, MAX)
puts 'Do you want to play a game?'

until game.done
  puts "Select a integer between #{game.min_num} and #{game.max_num}"
  input = gets.strip
  input = case input
          when 'Q!'
            puts "Game over, Answer was: #{game.tell}" # quit game
            false
          when 'N!'
            puts 'New Game'
            game.new! # new game
            false
          else
            Integer(input) rescue false
          end

  if input && input.between?(game.min_num, game.max_num)
    value = case game.guess(input)
            when -1 then 'Lower'
            when 0 then 'Correct!'
            when 1 then 'Higher'
            end
    puts "#{input} is #{value}, attempt# #{game.trys}"
  end
end
exit
