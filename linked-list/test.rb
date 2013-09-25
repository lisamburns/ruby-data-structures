require_relative 'linked-list'

ll = LinkedList.new
ll.push(1)
ll.push(2)
ll.push(3)

puts "Before removing"
ll.each { |i| puts i }

link = ll[1]
link.remove
puts "After removing"
ll.each { |i| puts i }

link = ll[0]
link.insert("a")
puts "After re-adding"
ll.each { |i| puts i }
