class Challenge_number
  def initialize (min_num = 0, max_num = min_num + 100)
    self.MIN = min_num
    self.MAX = max_num
    if @MIN < @MAX
      @number=(@MIN + Random.rand(@MAX))
    else
      raise RangeError => "#{@MIN} is not less then #{@MAX}"
    end
  end

  def MIN
    @MIN
  end
  def MAX
    @MAX
  end
  private
  def ensure_i(value)
     raise TypeError => "Not an Integer" unless value.is_a? Integer
  end
  def MIN=(value)
      ensure_i(value)
      @MIN = value
      @MIN.freeze()
  end
  def MAX=(value)
      ensure_i(value)
      @MAX = value
      @MAX.freeze()
  end
end
