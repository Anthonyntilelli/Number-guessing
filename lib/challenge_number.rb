################################################################################
#: Title        : ChallengeNumber
#: Author       : Anthony Tilelli
#: Description  : Generates random number for user ot guess
#: Main Methods :
#:      #guess - return if integer is higher,lower or is number and tracks tries
#:      #tell - end game with loss and returns number
#:      #new_game! - reset number, tries win and done
#:      #tries - count of attempt made to guess number
#:      #win - did player with> (T/F)
#:      #done - is game over? (T/F)
#:      if done == true and win == false, this indicates a loss
################################################################################
class ChallengeNumber
  attr_reader :min_num, :max_num, :tries, :win, :done

  def initialize(min_num, max_num, overide = nil)
    # use overide to force number
    self.min_num = min_num
    self.max_num = max_num
    raise RangeError => "#{@min_num} < #{@max_num}" unless @min_num < @max_num
    new_game!(overide)
  end

  # method used for user to attempt to find number ad track tries
  # retun -1 when integer is Lower then number
  # return 1 when integer is Higher then number
  # return 0 when integer == number
  # Guessing can still be used but will not increment tries after finding number
  def guess(integer)
    ensure_i(integer)
    @tries += 1 if @done == false
    compare = @number <=> integer
    if compare.zero? && !@done
      @done = true
      @win = true
    end
    compare
  end

  #  end game with loss and returns number
  def tell
    @done = true
    @number
  end

  # Resets number and tries within the prevous number range
  def new_game!(overide = nil)
    if overide # use overide to force number
      ensure_i(overide)
      @number = overide
    else
      @number = rand(@min_num..@max_num)
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
