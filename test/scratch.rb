require 'fuzzbert'

FB = FuzzBert::Binary

f1 = FB::Object.new(FB::Generators.random(10))
p f1.to_data

f2 = FB::Object.new { "Hooray" }
p f2.to_data

f3 = FB::Object.new(FB::Generators.cycle(%w{ a b c }))
5.times { p f3.to_data }

f4 = FB::Object.new(FB::Generators.cycle(0..10))
12.times { p f4.to_data }

container = FuzzBert::Container.new([f1, f2, f3, f4])

p container.to_data
