
class FuzzBert::Container

  def initialize(objects=[])
    @objects = objects
  end

  def <<(obj)
    @objects << obj
  end

  def to_data
    "".tap do |buf|
      @objects.each { |obj| buf << obj.to_data }
    end
  end

end


