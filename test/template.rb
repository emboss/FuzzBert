require 'fuzzbert'

t = FuzzBert::Template.new <<-EOS
abcdefg{{one}}hijklmmnop{{two}}qrstuvwxyz
EOS

t.set(:one) { 1 }
t.set(:two) { 2 }

puts t.to_data
