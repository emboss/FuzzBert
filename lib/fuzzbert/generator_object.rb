
class FuzzBert::GeneratorObject

  def initialize(generator=nil, &blk)
    @generator = generator || blk
    raise RuntimeError.new("No generator given") unless @generator
  end

  def to_data
    @generator.call
  end

end

