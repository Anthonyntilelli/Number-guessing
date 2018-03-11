################################################################################
#: Title        : ChallengeNumber
#: Author       : Anthony Tilelli
#: Description  : Generates random number for user ot guess
#: Main Methods :
#:      #guess - returns if guess is higher,lower or correct and tracks tries
#:      #tell - end game with loss and returns hidden_number
#:      #new_game! - reset hidden_number, tries and win
#:      #tries - count of attempt made to guess hidden_number
#:      #win - is game over (win/loss) or ongong
#:      #convert_integer - converts input to base 10 integer for use in game
#:                         returns 'nil' if invalid input
#: Win/Loss :
#:      gme ongoing when win == nil
#:      win when win == true
#:      Loss when  win == false
################################################################################
class ChallengeNumber
  attr_reader :min_num, :max_num, :tries, :win

  def initialize(min_num, max_num, overide = nil)
    # use overide to force hidden_number
    self.min_num = min_num
    self.max_num = max_num
    raise RangeError => "#{@min_num} < #{@max_num}" unless @min_num < @max_num
    new_game!(overide)
  end

  # method used for user to attempt to find hidden_number ad track tries
  # retun -1 when integer is Lower then hidden_number
  # return 1 when integer is Higher then hidden_number
  # return 0 when integer == hidden_number
  # return false when integer is out of range(doesn't increment try) or invalid
  # finding hidden_number ends game
  # will not increment tries after game end
  # will still return -1,0,1 after game end
  def guess(integer)
    integer = convert_integer(integer)

    # also checks for nil
    return false unless integer&.between?(@min_num, @max_num)
    @tries += 1 if @win.nil?
    compare = @hidden_number <=> integer
    @win = true if compare.zero?
    compare
  end

  #  end game with loss and returns hidden_number
  def tell
    @win = false
    @hidden_number
  end

  #  reset hidden_number, tries, and win
  def new_game!(overide = nil)
    if overide # use overide to force hidden_number
      ensure_i(overide)
      @hidden_number = overide
    else
      @hidden_number = rand(@min_num..@max_num)
    end
    @tries = 0
    @win = nil
  end

  # converts to base 10 integer or returns nil
  def convert_integer(var)
    Integer(var, 10) # allow base 10 only
  rescue ArgumentError
    nil
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
