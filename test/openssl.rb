require 'fuzzbert'

bin = FuzzBert::GeneratorObject.new(FuzzBert::Generators.random)

test = FuzzBert::Test.new do |data|
 IO.popen("openssl asn1parse -inform DER -noout", "w") do |io|
  io.write(data)
 end
 status = $?
 unless status.exited? && status.success?
   raise RuntimeError.new("bug!")
 end
end

executor = FuzzBert::Executor.new(test)
executor.run(bin)

