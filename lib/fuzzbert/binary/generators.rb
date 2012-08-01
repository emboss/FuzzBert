
module FuzzBert::Binary::Generators

  class << self

    def random(limit=1024)
      -> { FuzzBert::PRNG.bytes(limit) }
    end

    def cycle(range)
      ary = range.to_a
      i = 0
      lambda do
        ret = ary[i]
        i = (i + 1) % ary.size
        ret
      end
    end
    
    def fixed(data)
      -> { data }
    end

    def sample(ary)
      -> { ary.sample }
    end

  end

end
