require 'fuzzbert'

FB = FuzzBert::Binary

f1 = FB::Object.new(FB::Generators.random(10))
f2 = FB::Object.new { "Hooray" }
f3 = FB::Object.new(FB::Generators.cycle(%w{ a b c }))
f4 = FB::Object.new(FB::Generators.cycle(0..10))
container = FuzzBert::Container.new([f1, f2, f3, f4])
container.to_data

test = FuzzBert::Test.new do |data|
  #puts "Working..."
  Process.kill(:SEGV, Process.pid)
  #raise RuntimeError.new("Le bug")
end

executor = FuzzBert::Executor.new(test)
executor.run([container])

