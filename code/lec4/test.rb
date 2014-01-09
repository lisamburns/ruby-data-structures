require_relative './hash_set'

h = HashSet.new

50.times do |i|
  h.insert(i)
end

50.times do |i|
  raise "hell: #{i}" if h.include?(i)
end
