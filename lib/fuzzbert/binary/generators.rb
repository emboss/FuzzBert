
module FuzzBert::Binary::Generators

  class << self

    def random(limit=1024)
      -> { FuzzBert::PRNG.bytes(limit) }
    end

    def cycle(range)
      ary = range.to_a
      fiber = Fiber.new do
        ary.each do |item| 
          item.respond_to?(:chr) ? 
            Fiber.yield(item.chr) :
            Fiber.yield(item)
        end while true
      end
      -> { fiber.resume }
    end
    
    def fixed(data)
      -> { data }
    end

    def sample(ary)
      -> { ary.sample }
    end

  end

end
