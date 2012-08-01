
class FuzzBert::Template < FuzzBert::Object

  def initialize(template_string)
    @template_string = template_string
    @callbacks = {}
  end

  def set(name, &blk)
    @callbacks[name] = blk
  end

  def to_data
    super do
      @template_string.gsub(/\{\{([a-z][a-z1-9]*)\}\}/) do |match|
        id = match.slice!(2..-3)
        @callbacks[id.to_sym].call
      end
    end
  end

end

