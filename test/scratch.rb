require 'fuzzbert'

f1 = FuzzBert::GeneratorObject.new(FuzzBert::Generators.random(10))
f2 = FuzzBert::GeneratorObject.new { "Hooray" }
f3 = FuzzBert::GeneratorObject.new(FuzzBert::Generators.cycle(%w{ a b c }))
f4 = FuzzBert::GeneratorObject.new(FuzzBert::Generators.cycle(0..10))
container = FuzzBert::Container.new([f1, f2, f3, f4])

test = FuzzBert::Test.new do |data|
  #puts "Working..."
  Process.kill(:SEGV, Process.pid)
  #raise RuntimeError.new("Le bug")
end

executor = FuzzBert::Executor.new(test)
executor.run([container])

