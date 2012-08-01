
class FuzzBert::Container < FuzzBert::Object

  def initialize(objects=[])
    @objects = objects
  end

  def <<(obj)
    @objects << obj
  end

  def to_data
    super do
      "".tap do |buf|
        @objects.each { |obj| buf << obj.to_data }
      end
    end
  end

end


