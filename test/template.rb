require 'fuzzbert'

t = FuzzBert::Template.new <<-EOS
abcdefg{one}hij\\{kl\\}mmnop{two}{three}qrstuvwxyz
EOS

t.set(:one) { "1" }
t.set(:two) { "2" }
t.set(:three) { "3" }

puts t.to_data
