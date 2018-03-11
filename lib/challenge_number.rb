################################################################################
#: Title        : ChallengeNumber
#: Author       : Anthony Tilelli
#: Description  : Generates random number for user ot guess
#: Main Methods :
#:      #guess - returns if guess is higher,lower or correct and tracks tries
#:      #tell - end game with loss and returns hidden_number
#:      #new_game! - reset hidden_number, tries, win and done
#:      #tries - count of attempt made to guess hidden_number
#:      #win - did player with> (T/F)
#:      #done - is game over? (T/F)
#: Win/Loss :
#:      when when (done == true and win == true)
#:      Loss when (done == true and win == false)
################################################################################
class ChallengeNumber
  attr_reader :min_num, :max_num, :tries, :win, :done

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
  # return false when integer is out off range (does not count as try)
  # finding hidden_number ends game
  # will not increment tries after game end
  # will still return -1,0,1 after game end
  def guess(integer)
    ensure_i(integer)
    return false unless integer.between?(@min_num, @max_num)
    @tries += 1 if @done == false
    compare = @hidden_number <=> integer
    if compare.zero? && !@done
      @done = true
      @win = true
    end
    compare
  end

  #  end game with loss and returns hidden_number
  def tell
    @done = true
    @hidden_number
  end

  #  reset hidden_number, tries, win, and done
  def new_game!(overide = nil)
    if overide # use overide to force hidden_number
      ensure_i(overide)
      @hidden_number = overide
    else
      @hidden_number = rand(@min_num..@max_num)
    end
    @tries = 0
    @done = false
    @win = false
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
