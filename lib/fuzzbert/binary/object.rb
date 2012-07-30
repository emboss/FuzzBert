
class FuzzBert::Binary::Object < FuzzBert::Object

  def initialize(generator=nil, &blk)
    @generator = generator || blk
    raise RuntimeError.new("No generator given") unless @generator
  end

  def to_data
    super &@generator
  end

end

